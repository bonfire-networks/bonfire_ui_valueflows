defmodule Bonfire.UI.ValueFlows.CreateUnitLive do
  use Bonfire.UI.Common.Web, :live_component
  alias Bonfire.UI.ValueFlows.CreateUnitForm

  def mount(socket) do
    changeset = CreateUnitForm.changeset()

    {:ok,
     assign(socket,
       changeset: changeset
     )}
  end

  def handle_event("validate_unit", %{"create_unit_form" => params}, socket) do
    debug(params)
    changeset = CreateUnitForm.changeset(params)
    changeset = Map.put(changeset, :action, :insert)
    socket = assign(socket, changeset: changeset)
    {:noreply, socket}
  end

  def handle_event("submit_unit", %{"create_unit_form" => params}, socket) do
    changeset = CreateUnitForm.changeset(params)

    case CreateUnitForm.send(changeset, params, socket) do
      {:ok, unit} ->
        send(self(), {:add_unit, unit})

        {
          :noreply,
          socket

          #  |> assign(all_units: [unit] ++ assigns(socket).all_units)
        }

      {:error, changeset} ->
        {:noreply, assign(socket, changeset: changeset)}

      {_, message} ->
        assign({:noreply, assign_flash(socket, :error, message)},
          changeset: CreateUnitForm.changeset(%{})
        )
    end
  end
end
