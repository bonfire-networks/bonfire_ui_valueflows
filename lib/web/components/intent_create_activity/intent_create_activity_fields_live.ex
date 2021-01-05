defmodule Bonfire.UI.ValueFlows.IntentCreateActivityFieldsLive do
  use Bonfire.Web, :live_component
  alias ValueFlows.Planning.Intent.Intents
  alias Bonfire.Geolocate.Geolocations
  alias Bonfire.UI.Social.SelectAutocompleteLive

  def mount(socket) do
    {:ok, loc} = Geolocations.many()
    locations = Enum.map(loc, fn (x) -> Map.take(x, [:name, :id]) end)
    {:ok, socket
    |> assign(is_public: false, locations: locations )}
  end

  def handle_event("toggleIsPublic", _ , socket) do

    socket = assign(socket, is_public: !socket.assigns.is_public)

    {:noreply, socket}
 end



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