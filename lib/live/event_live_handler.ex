defmodule ValueFlows.EconomicEvent.LiveHandler do
  use Bonfire.UI.Common.Web, :live_handler
  use Arrows

  alias ValueFlows.EconomicEvent
  alias ValueFlows.EconomicEvent.EconomicEvents

  def handle_event("create", attrs, socket) do
    # |> debug("creator")
    creator = current_user_required!(socket)
    # debug(socket: socket)

    with uploaded_media <-
           live_upload_files(
             creator,
             attrs["upload_metadata"],
             socket
           ),
         obj_attrs <-
           attrs
           # |> debug()
           |> Map.merge(attrs["economic_event"])
           |> Map.drop(["economic_event"])
           |> input_to_atoms()
           # |> Map.get(:event)
           |> prepare_attrs(creator)
           |> maybe_put(:resource_image_id, List.first(uploaded_media))
           |> debug("create_event_attrs"),
         %{valid?: true} = cs <- changeset(obj_attrs),
         {:ok, event} <- EconomicEvents.create(creator, obj_attrs) do
      # debug(created: event)

      if e(event, :economic_resource, :id, nil) do
        {:noreply,
         redirect_to(
           socket,
           e(attrs, "redirect_after", ~p"/resource") <>
             "/" <>
             e(event, :economic_resource, :id, "")
         )}
      else
        {:noreply, redirect_to(socket, path(e(event, :economic_event, nil)))}

        # {:noreply, socket |> assign_flash(:success, "Event recorded!")}
      end

      # else
      #   {:error, error} ->
      #     {:noreply, assign(socket, form_error: Errors.error_msg(error))}

      #   %Ecto.Changeset{} = cs ->
      #     {:noreply, assign(socket, changeset: cs, form_error: Errors.error_msg(cs))} #|> IO.inspect
    end
  end

  def prepare_attrs(attrs, creator) do
    attrs
    |> EconomicEvents.prepare_create_attrs(creator)
    |> maybe_put(
      :has_point_in_time,
      maybe_date(e(attrs, :has_point_in_time, nil))
    )
    |> maybe_put(:has_beginning, maybe_date(e(attrs, :has_beginning, nil)))
    |> maybe_put(:has_end, maybe_date(e(attrs, :has_end, nil)))
  end

  defp maybe_date(d) when is_binary(d) and d != "" do
    Date.from_iso8601(d)
    ~> NaiveDateTime.new(~T[00:00:00])
    ~> Ecto.Type.cast(:utc_datetime_usec, ...)
    # |> debug()
    |> ok_unwrap()
  end

  defp maybe_date(_d) do
    nil
  end

  defp changeset(attrs \\ %{}) do
    EconomicEvent.validate_changeset(attrs)
  end
end
