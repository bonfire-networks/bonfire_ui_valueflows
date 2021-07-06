defmodule Bonfire.UI.ValueFlows.CreateEconomicEventLive do
  use Bonfire.Web, :stateless_component

  prop action, :string, required: true
  prop remove, :string, required: true
  prop output_of_id, :string
  prop units, :list
end
