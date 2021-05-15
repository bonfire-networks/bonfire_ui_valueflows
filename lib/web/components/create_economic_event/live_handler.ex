defmodule Bonfire.UI.ValueFlows.CreateEconomicEventLive.LiveHandler do
  use Bonfire.Web, :live_handler


  def handle_event("autocomplete"=action, %{"autocomplete_resource_conforms_to" => search} = attrs, socket) when is_binary(search) and byte_size(search)>0 do
    ValueFlows.Knowledge.ResourceSpecification.LiveHandler.handle_event(action, search, socket)
  end

  def handle_event("autocomplete"=action, %{"autocomplete_resource_inventoried_as" => search} = attrs, socket) when is_binary(search) and byte_size(search)>0 do
    ValueFlows.EconomicResource.LiveHandler.handle_event(action, search, socket)
  end

  def handle_event("autocomplete"=action, %{"autocomplete_at_location" => search} = attrs, socket) when is_binary(search) and byte_size(search)>0 do
    Bonfire.Geolocate.LiveHandler.handle_event(action, search, socket)
  end

  def handle_event(_, _, socket) do
    {:noreply, socket}
  end
end
