defmodule Bonfire.UI.ValueFlows.SelectEconomicEventLive do
  use Bonfire.UI.Common.Web, :stateless_component

  prop process, :any
  prop units, :list
  prop resource, :any, default: nil
  prop extra_components, :list

  def preselect(%{id: id} = resource) do
    [{e(resource, :name, "Unnamed resource"), id}]
  end

  def preselect(_) do
    []
  end
end
