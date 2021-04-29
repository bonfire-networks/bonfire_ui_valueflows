defmodule Bonfire.UI.ValueFlows.CreateEconomicEventLive do
  use Bonfire.Web, :stateless_component

  prop action, :string, required: true
  prop remove, :string, required: true
end
