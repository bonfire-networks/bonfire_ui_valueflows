defmodule Bonfire.UI.ValueFlows.SelectEconomicEventLive do
  use Bonfire.UI.Common.Web, :stateless_component

  prop open, :boolean, default: true
  prop process, :any
  prop units, :list
  prop resource, :any, default: nil
  prop extra_components, :list, default: []
  prop textarea_class, :css_class, required: false

  def preselect(%{id: id} = resource) do
    [{e(resource, :name, "Unnamed resource"), id}]
  end

  def preselect(_) do
    []
  end
end
