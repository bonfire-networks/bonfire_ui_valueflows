defmodule Bonfire.UI.ValueFlows.MapLive do
  use Bonfire.Web, {:live_view, [layout: {Bonfire.UI.ValueFlows.LayoutView, "live.html"}]}

  use AbsintheClient, schema: Bonfire.GraphQL.Schema, action: [mode: :internal]

  alias Bonfire.Common.Web.LivePlugs

  def mount(params, session, socket) do
    LivePlugs.live_plug params, session, socket, [
      LivePlugs.LoadCurrentAccount,
      LivePlugs.LoadCurrentUser,
      LivePlugs.StaticChanged,
      LivePlugs.Csrf,
      &mounted/3,
    ]
  end

  defp mounted(params, session, socket) do
    # intents = Bonfire.UI.ValueFlows.ProposalLive.all_intents(socket)
    # IO.inspect(intents)

    {:ok, socket
    |> assign(
      page_title: "Map",
      selected_tab: "about",
      # list: intents
    )}
  end


end
