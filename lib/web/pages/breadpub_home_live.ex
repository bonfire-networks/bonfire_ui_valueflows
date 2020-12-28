defmodule Bonfire.UI.ValueFlows.BreadpubHomeLive do
  use Bonfire.Web, :live_view
  alias Bonfire.UI.Social.HashtagsLive
  alias Bonfire.UI.ValueFlows.IntentCreateActivityLive
  alias Bonfire.UI.ValueFlows.ProposalFeedLive
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
      {:ok, socket
      |> assign(page_title: "Switch User",
      selected_tab: "about",
      )}
    end

end
