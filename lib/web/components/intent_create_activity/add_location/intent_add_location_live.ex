defmodule Bonfire.UI.ValueFlows.IntentAddLocationLive do
  use Bonfire.Web, :live_component

  alias Bonfire.Geolocate.Geolocations

  def handle_event("location_clear", _, socket) do
    assigns = [
      at_location: ""
    ]
    {:noreply, assign(socket, assigns)}
  end

  def handle_event("location_search", %{"location_input" => search_for}, socket) do
    {:ok, locations} = Geolocations.many({:name_contains, search_for})
    IO.inspect(locations)
    # locations = Enum.map(loc, fn (x) -> Map.take(x, [:name, :id]) end)
    assigns = [
      location_search_results: locations, # search(Enum.map(locations, fn x -> x.name end), search_for),
      location_search_phrase: search_for
    ]
    IO.inspect(assigns)

    {:noreply, assign(socket, assigns)}
  end


  def handle_event("location_pick", %{"id" => _id, "name" => location_name} = loc, socket) do
    assigns = [
      location_search_results: [],
      location_search_phrase: location_name,
      at_location: input_to_atoms(loc),
    ]

    {:noreply, assign(socket, assigns)}
  end

  def handle_event("location_create", %{"location_input" => location_entered}, socket) do
    assigns = with {:ok, loc} <- Bonfire.Geolocate.Geolocations.create(socket.assigns.current_user, %{name: location_entered, mappable_address: location_entered}) do
      [
        location_search_results: [],
        location_search_phrase: "",
        at_location: loc,
      ]
    else e ->
      IO.inspect(error: e)
      []
    end

    {:noreply, assign(socket, assigns)}
  end

  def search(""), do: []

  def search(list, prefix) do
    Enum.filter(list, &has_prefix?(&1, prefix))
  end

  defp has_prefix?(item, prefix) do
    String.starts_with?(String.downcase(item), String.downcase(prefix))
  end

end
