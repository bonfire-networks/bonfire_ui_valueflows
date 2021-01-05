defmodule Bonfire.UI.ValueFlows.BreadpubHomeLive do
  use Bonfire.Web, {:live_view, [layout: {Bonfire.UI.ValueFlows.LayoutView, "live.html"}]}

  use AbsintheClient, schema: Bonfire.GraphQL.Schema, action: [mode: :internal]

  alias Bonfire.UI.Social.{HashtagsLive, ParticipantsLive}
  alias Bonfire.UI.ValueFlows.{IntentCreateActivityLive, ProposalFeedLive, FiltersLive}
  alias Bonfire.Common.Web.LivePlugs
  alias Bonfire.Me.Users
  alias Bonfire.Me.Web.{CreateUserLive, MeHomeLive}

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
    intents = all_intents(socket)
    IO.inspect(intents)

    {:ok, socket
    |> assign(
      page_title: "Home",
      selected_tab: "about",
      list: intents
    )}
  end


  @graphql """
    {
      intents {
        id
        name
        provider
        receiver
        at_location
      }
    }
  """
  def intents(params \\ %{}, socket), do: liveql(socket, :intents, params)
  def all_intents(socket), do: intents(socket)


end
