defmodule Bonfire.UI.ValueFlows.IntentCreateActivityFieldsLive do
  use Bonfire.Web, :live_component
  alias ValueFlows.Planning.Intent.Intents
  alias Bonfire.UI.ValueFlows.{IntentAddLocationLive, IntentCreateLabelLive, IntentPickLabelLive, IntentAddMilestoneLive}
  alias Bonfire.Geolocate.Geolocations
  use AbsintheClient, schema: Bonfire.GraphQL.Schema, action: [mode: :internal]

  def mount(socket) do
    processes = all_processes(socket)
    {:ok, socket
    |> assign(
      is_public: false,
      at_location: %{},
      milestone: %{},
      due_date: "",
      location_search_results: [],
      location_search_phrase: "",
      milestone_search_results: processes,
      milestone_search_phrase: ""
    )}
  end

  def handle_event("clear_due_date", _, socket) do
    assigns = [
      due_date: ""
    ]
    {:noreply, assign(socket, assigns)}
  end

  def handle_event("set_due", %{"due_date" => due}, socket) do
    assigns = [
      due_date: due,
    ]

    {:noreply, assign(socket, assigns)}
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
          receiver: socket.assigns.current_user
        })

        {:ok, intent} = Intents.create(user, data)
        IO.inspect(intent)

      end

      {:noreply, socket}
  end


  # START FUNCTIONS FOR INTENT ADD LOCATION FORM
  # ive tried to move them all in the intent_add_location_live module, making it stateful,
  # but I need the at_location param in the parent compoent (this one), to be used when creating the new intent --> DO YOU?
  # it seems send(self) only works with the parent view and not with the parent component
  # maybe wrong?
  # WELL, let's see if this "function proxying" can work for that

  def handle_event("location_"<>_action = event, params, socket) do
    IO.inspect(proxy_event: event)
    IO.inspect(proxy_params: params)
    Bonfire.UI.ValueFlows.IntentAddLocationLive.handle_event(event, params, socket)
  end

  # END FUNCTIONS FOR INTENT ADD LOCATIONS

  def handle_event("milestone_"<>_action = event, params, socket) do
    IO.inspect(proxy_event: event)
    IO.inspect(proxy_params: params)
    Bonfire.UI.ValueFlows.IntentAddMilestoneLive.handle_event(event, params, socket)
  end



  @graphql """
    {
      processes {
        id
        name
      }
    }
  """
  def processes(params \\ %{}, socket), do: liveql(socket, :processes, params)
  def all_processes(socket), do: processes(socket)

end
