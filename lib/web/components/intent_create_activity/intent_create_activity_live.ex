defmodule Bonfire.UI.ValueFlows.IntentCreateActivityLive do
  use Bonfire.Web, :live_component
  alias ValueFlows.Planning.Intent.Intents
  alias Bonfire.Geolocate.Geolocations

  def mount(socket) do
    {:ok, socket
    |> assign(selected_tab: "")}
  end


  def handle_event("toggleProposal", %{"id" => id}, socket) do

     socket = assign(socket, selected_tab: id)

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
          is_public: true,
          at_location: location,
          receiver: location
        })

        {:ok, intent} = Intents.create(user, data)
        IO.inspect(intent)

      end

      {:noreply, socket}
  end
end
