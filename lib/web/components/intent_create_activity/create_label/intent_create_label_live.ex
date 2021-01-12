defmodule Bonfire.UI.ValueFlows.IntentCreateLabelLive do
  use Bonfire.Web, :live_component

  alias Bonfire.Geolocate.Geolocations

  def mount(socket) do

    {:ok, socket
    |> assign(
      location_search_results: [],
      location_search_phrase: ""
    )}
  end
end