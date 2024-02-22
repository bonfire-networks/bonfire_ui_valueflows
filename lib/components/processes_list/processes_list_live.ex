defmodule Bonfire.UI.ValueFlows.ProcessesListLive do
  use Bonfire.UI.Common.Web, :stateless_component
  # use AbsintheClient, schema: Bonfire.API.GraphQL.Schema, action: [mode: :internal]

  prop title, :string, default: nil
  prop process_url, :string, default: nil

  # declare_nav_component("List of lists/processes")

  def processes(context) do
    if context[:my_processes] do
      context[:my_processes]
    else
      current_user = current_user(context)

      if current_user do
        my_processes(current_user)
      else
        []
      end
    end

    # |> debug("my_processes")
  end

  def my_processes(current_user) do
    if not is_nil(current_user),
      do:
        Bonfire.Social.Likes.by_liker(current_user,
          object_type: ValueFlows.Process,
          preload: false
        )
        |> repo().maybe_preload(edge: [:object])
        |> Enum.map(&e(&1, :edge, :object, nil))

    # |> debug()
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
