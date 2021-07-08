defmodule Bonfire.UI.ValueFlows.CreateEconomicEventLive do
  use Bonfire.Web, :stateless_component

  prop action, :string, required: true
  prop remove, :string, required: true
  prop output_of_id, :string
  prop units, :list

  def mount(socket) do
    {:ok, socket |> assign(
      form_error: "",
      changeset: ValueFlows.EconomicEvent.validate_changeset()
      )}
  end

end
