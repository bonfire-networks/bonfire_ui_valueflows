defmodule ValueFlows.Knowledge.ResourceSpecification.LiveHandler do
  use Bonfire.UI.Common.Web, :live_handler

  alias ValueFlows.Knowledge.ResourceSpecification
  alias ValueFlows.Knowledge.ResourceSpecification.ResourceSpecifications

  def changeset(attrs \\ %{}) do
    ResourceSpecification.create_changeset(nil, attrs)
  end

  def handle_event("create", attrs, socket) do
    creator = current_user_required!(socket)

    with uploaded_media <-
           live_upload_files(
             creator,
             attrs["upload_metadata"],
             socket
           ),
         obj_attrs <-
           attrs
           #  |> debug()
           |> Map.merge(attrs["resource_spec"])
           |> input_to_atoms()
           # |> Map.get(:resource_spec)
           |> ResourceSpecifications.prepare_attrs()
           |> maybe_put(:image_id, uid(List.first(uploaded_media)))
           |> debug(),
         %{valid?: true} = cs <- changeset(obj_attrs),
         {:ok, resource_spec} <-
           ResourceSpecifications.create(creator, obj_attrs) do
      # debug(resource_spec)
      {:noreply,
       redirect_to(
         socket,
         e(attrs, "redirect_after", ~p"/resource_spec") <> "/" <> resource_spec.id
       )}
    end
  end

  def handle_event("autocomplete", %{"value" => search}, socket),
    do: handle_event("autocomplete", search, socket)

  def handle_event("autocomplete", search, socket) when is_binary(search) do
    options =
      (ResourceSpecifications.search(search) || [])
      |> Enum.map(&to_tuple/1)

    options =
      options ++
        [{"Create a new resource specification called: " <> search, search}]

    debug(options: options)

    {:noreply, assign_global(socket, resource_specifications_autocomplete: options)}
  end

  def handle_event(
        "select",
        %{"id" => select_resource_spec, "name" => name} = attrs,
        socket
      )
      when is_binary(select_resource_spec) do
    # debug(socket)

    selected =
      if !is_uid?(select_resource_spec),
        do: create_in_autocomplete(current_user(socket), select_resource_spec),
        else: {name, select_resource_spec}

    debug(selected)

    {:noreply, assign_global(socket, resource_specification_selected: [selected])}
  end

  def to_tuple(resource_spec) do
    {resource_spec.name, resource_spec.id}
  end

  def create_in_autocomplete(creator, name) do
    with {:ok, rs} <- ResourceSpecifications.create(creator, %{name: name}) do
      {rs.name, rs.id}
    end
  end
end
