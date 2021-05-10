defmodule Bonfire.UI.ValueFlows.CreateEconomicEventLive.LiveHandler do
  use Bonfire.Web, :live_handler


  def handle_event("autocomplete"=action, %{"autocomplete_resource_conforms_to" => search} = attrs, socket) when is_binary(search) do
    ValueFlows.Knowledge.ResourceSpecification.LiveHandler.handle_event(action, attrs, socket)
  end

  def handle_event("autocomplete"=action, %{"autocomplete_resource_inventoried_as" => search} = attrs, socket) when is_binary(search) do
    ValueFlows.EconomicResource.LiveHandler.handle_event(action, attrs, socket)
  end


end
