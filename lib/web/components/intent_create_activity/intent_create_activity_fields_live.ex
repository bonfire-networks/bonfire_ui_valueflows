defmodule Bonfire.UI.ValueFlows.IntentCreateActivityFieldsLive do
  use Bonfire.Web, :live_component
  alias ValueFlows.Planning.Intent.Intents
  alias Bonfire.Geolocate.Geolocations
  alias Bonfire.UI.ValueFlows.IntentAddLocationLive

  def mount(socket) do
   
    {:ok, socket
    |> assign(
      toggled_location: false,
      is_public: false, 
      at_location: "",
      search_locations_results: [],
      search_location_phrase: "" )}
  end

  def handle_event("toggleIsPublic", _ , socket) do
    socket = assign(socket, is_public: !socket.assigns.is_public)
    {:noreply, socket}
 end


 def handle_event("toggle_location", _ , socket) do
  socket = assign(socket, toggled_location: !socket.assigns.toggled_location)
  {:noreply, socket}
  end




  # START FUNCTIONS FOR INTENT ADD LOCATION FORM
  # ive tried to move them all in the intent_add_location_live module, making it stateful, 
  # but I need the at_location param in the parent compoent (this one), to be used when creating the new intent
  # it seems send(self) only works with the parent view and not with the parent component
  # maybe wrong? 

  def handle_event("clear_location", _, socket) do
    assigns = [
      at_location: ""
    ]
    {:noreply, assign(socket, assigns)}
  end

  def handle_event("search_location", %{"at_location" => at_location}, socket) do
    IO.inspect(at_location)
    {:ok, loc} = Geolocations.many()
    locations = Enum.map(loc, fn (x) -> Map.take(x, [:name, :id]) end)
    assigns = [
      search_locations_results: search(Enum.map(locations, fn x -> x.name end), at_location),
      search_location_phrase: at_location
    ]

    {:noreply, assign(socket, assigns)}
  end

  def search(""), do: []

  def search(list, prefix) do
    Enum.filter(list, &has_prefix?(&1, prefix))
  end

  defp has_prefix?(item, prefix) do
    String.starts_with?(String.downcase(item), String.downcase(prefix))
  end

  def handle_event("pick_location", %{"name" => picked}, socket) do
    IO.inspect(picked)

    assigns = [
      search_locations_results: [],
      search_location_phrase: "",
      at_location: picked,
      toggled_location: false
    ]

    {:noreply, assign(socket, assigns)}
  end

  def handle_event("create_location", %{"at_location" => picked}, socket) do
    IO.inspect(picked)

    assigns = [
      search_locations_results: [],
      search_location_phrase: "",
      at_location: picked,
      toggled_location: false
    ]

    {:noreply, assign(socket, assigns)}
  end

  # END FUNCTIONS FOR INTENT ADD LOCATIONS

  def handle_event("create", attrs, socket) do

      user = Map.get(socket.assigns, :current_user)

      need = input_to_atoms(Map.get(attrs, "need"))

      if Map.get(need, :name) do

        address = Map.get(need, :at_location)
        location = if(address) do
          with {:ok, geo} <- Geolocations.create(user, %{name: address, mappable_address: address}) do
            geo
          end
        end

        data = need |> Map.merge(%{
          action: "work",
          is_public: socket.assigns.is_public,
          at_location: location,
          receiver: location
        })

        {:ok, intent} = Intents.create(user, data)
        IO.inspect(intent)

      end

      {:noreply, socket}
  end


end