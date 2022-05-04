defmodule Bonfire.UI.ValueFlows.CreateEconomicEventLive do
  use Bonfire.UI.Common.Web, :stateless_component

  prop action, :string, required: true
  prop remove, :string, required: true
  prop input_of_id, :string
  prop output_of_id, :string
  prop units, :list
  prop changeset, :any
  prop form_error, :string, default: ""
  prop economic_resource_selected, :any, default: []
  prop extra_components, :list

  def mount(socket) do
    {:ok, socket |> assign(
      form_error: "",
      changeset: ValueFlows.EconomicEvent.validate_changeset()
      )}
  end

end
