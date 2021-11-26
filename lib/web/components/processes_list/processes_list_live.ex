defmodule Bonfire.UI.ValueFlows.ProcessesListLive do
  use Bonfire.Web, :stateless_component
  # use AbsintheClient, schema: Bonfire.GraphQL.Schema, action: [mode: :internal]
  alias Surface.Components.LivePatch

  prop title, :string, default: "Lists"
  prop process_url, :string, default: "/list/"

  # FIXME! update no longer works in stateless
  def update(assigns, socket) do

    processes =
      if current_user(assigns) do
        Bonfire.Social.Likes.by_liker(current_user(assigns), ValueFlows.Process)
        |> Enum.map(&(&1.liked))
      else
        []
      end

    {:ok,
    socket
    |> assigns_merge(assigns,
      processes: processes # processes(socket)
    )}
  end

  # @graphql """
  #   {
  #     processes {
  #       id
  #       name
  #       note
  #     }
  #   }
  # """
  # def processes(params \\ %{}, socket), do: liveql(socket, :processes, params)

end
