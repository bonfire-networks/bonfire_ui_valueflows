defmodule Bonfire.UI.ValueFlows.ProposalLive do
  use Bonfire.Web, {:live_view, [layout: {Bonfire.UI.ValueFlows.LayoutView, "live.html"}]}

  alias Bonfire.Common.Web.LivePlugs
  alias Bonfire.Me.Users
  alias Bonfire.UI.Social.{ParticipantsLive}
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
    {:ok, socket
    |> assign(page_title: "Proposal",
    selected_tab: "about",
    )}
  end

end
