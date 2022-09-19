defmodule Bonfire.UI.ValueFlows.CreateResourceSpecificationLive do
  use Bonfire.UI.Common.Web, :live_component
  alias Bonfire.UI.ValueFlows.CreateResourceSpecForm

  def mount(socket) do
    changeset = CreateResourceSpecForm.changeset()

    {:ok,
     assign(socket,
       changeset: changeset
     )}
  end

  def handle_event(
        "validate_resource",
        %{"create_resource_spec_form" => params},
        socket
      ) do
    debug(params)
    changeset = CreateResourceSpecForm.changeset(params)
    changeset = Map.put(changeset, :action, :insert)
    socket = assign(socket, changeset: changeset)
    {:noreply, socket}
  end

  def handle_event(
        "submit_resource",
        %{"create_resource_spec_form" => params},
        socket
      ) do
    changeset = CreateResourceSpecForm.changeset(params)

    case CreateResourceSpecForm.send(changeset, params, socket) do
      {:ok, resource} ->
        send(self(), {:add_resource_specification, resource})
        {:noreply, socket}

      {:error, changeset} ->
        {:noreply, assign(socket, changeset: changeset)}

      {_, message} ->
        {:noreply,
         socket
         |> assign(changeset: CreateResourceSpecForm.changeset(%{}))
         |> assign_flash(:error, message)}
    end
  end
end
