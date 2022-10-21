defmodule Bonfire.UI.ValueFlows.CreateValueCalculationLive do
  use Bonfire.UI.Common.Web, :live_component
  alias Bonfire.UI.ValueFlows.CreateValueCalculationForm

  def mount(socket) do
    changeset = CreateValueCalculationForm.changeset()

    {:ok,
     assign(socket,
       changeset: changeset
     )}
  end

  def handle_event(
        "validate_value_calculation",
        %{"create_value_calculation_form" => params},
        socket
      ) do
    debug(params)
    changeset = CreateValueCalculationForm.changeset(params)
    changeset = Map.put(changeset, :action, :insert)
    socket = assign(socket, changeset: changeset)
    {:noreply, socket}
  end

  def handle_event(
        "submit_value_calculation",
        %{"create_value_calculation_form" => params},
        socket
      ) do
    changeset = CreateValueCalculationForm.changeset(params)

    case CreateValueCalculationForm.send(changeset, params, socket) do
      {:ok, vc} ->
        send(self(), {:add_vc, vc})
        {:noreply, socket}

      {:error, changeset} ->
        {:noreply, assign(socket, changeset: changeset)}

      {_, message} ->
        assign({:noreply, assign_flash(socket, :error, message)},
          changeset: CreateValueCalculationForm.changeset(%{})
        )
    end
  end
end
