defmodule Bonfire.UI.ValueFlows.ProcessesListLive do
  use Bonfire.Web, :stateless_component
  use AbsintheClient, schema: Bonfire.GraphQL.Schema, action: [mode: :internal]
  alias Surface.Components.LivePatch

  prop title, :string, default: "Lists"
  prop process_url, :string, default: "/list/"

  def update(assigns, socket) do

    {:ok,
    socket
    |> assigns_merge(assigns,
      processes: processes(socket)
    )}
  end

  @graphql """
    {
      processes {
        id
        name
        note
      }
    }
  """
  def processes(params \\ %{}, socket), do: liveql(socket, :processes, params)

end
