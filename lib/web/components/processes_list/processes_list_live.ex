defmodule Bonfire.UI.ValueFlows.ProcessesListLive do
  use Bonfire.UI.Common.Web, :stateless_component
  # use AbsintheClient, schema: Bonfire.API.GraphQL.Schema, action: [mode: :internal]
  alias Surface.Components.LivePatch

  prop title, :string, default: nil
  prop process_url, :string, default: nil

  declare_nav_component("List of lists/processes")

  def processes(current_user) do
    if current_user do
      Bonfire.Social.Likes.by_liker(current_user, object_type: ValueFlows.Process)
      |> repo().maybe_preload(edge: [:object])
      |> Enum.map(&e(&1, :edge, :object, nil))

      # |> debug()
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
