defmodule Bonfire.UI.ValueFlows.AddMilestoneLive do
  use Bonfire.Web, :live_component
  use AbsintheClient, schema: Bonfire.GraphQL.Schema, action: [mode: :internal]

  alias Bonfire.UI.ValueFlows.CreateMilestoneLive

  def handle_event("milestone_clear", _, socket) do
    assigns = [
      milestone: ""
    ]
    {:noreply, assign(socket, assigns)}
  end

  def handle_event("milestone_search", %{"milestone_input" => search_for}, socket) do
    processes = all_processes(socket)
    IO.inspect("search_for")
    IO.inspect(search_for)

    # locations = Enum.map(loc, fn (x) -> Map.take(x, [:name, :id]) end)
    assigns = [
      milestone_search_results: search(processes, search_for),
      milestone_search_phrase: search_for
    ]
    IO.inspect(assigns)

    {:noreply, assign(socket, assigns)}
  end

  def handle_event("milestone_pick", %{"id" => _id, "name" => milestone_name} = milestone, socket) do
    processes = all_processes(socket)
    assigns = [
      milestone_search_results: processes,
      milestone_search_phrase: milestone_name,
      milestone: input_to_atoms(milestone),
    ]

    {:noreply, assign(socket, assigns)}
  end

  def search(""), do: []

  def search(list, prefix) do
    Enum.filter(list, &has_prefix?(&1, prefix))
  end

  defp has_prefix?(item, prefix) do
    String.starts_with?(String.downcase(item.name), String.downcase(prefix))
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
