defmodule Bonfire.UI.ValueFlows.ProcessesListLive do
  use Bonfire.UI.Common.Web, :stateless_component
  # use AbsintheClient, schema: Bonfire.API.GraphQL.Schema, action: [mode: :internal]
  alias Surface.Components.LivePatch

  prop title, :string, default: "Lists"
  prop process_url, :string, default: "/list/"

  def processes(assigns) do
    if current_user(assigns) do
      Bonfire.Social.Likes.by_liker(current_user(assigns), ValueFlows.Process)
      |> Enum.map(&(&1.liked))
    else
      []
    end
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
