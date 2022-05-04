defmodule Bonfire.UI.ValueFlows.AddLabelLive do
  use Bonfire.UI.Common.Web, :live_component

  alias Bonfire.Tag.Tags
  alias Bonfire.UI.ValueFlows.{CreateLabelLive, AddLabelLive}

  def mount(socket) do

    {:ok, socket
    |> assign(
      label_search_results: [],
      label_search_phrase: ""
    )}
  end

  def handle_event("label_search", %{"label_search" => search_for}, socket) do
    {:ok, labels} = Bonfire.Tag.Tags.many({:autocomplete, search_for})
    debug(labels)
    # labels = Enum.map(loc, fn (x) -> Map.take(x, [:name, :id]) end)
    assigns = [
      label_search_results: labels, # search(Enum.map(labels, fn x -> x.name end), search_for),
      label_search_phrase: search_for
    ]
    debug(assigns)

    {:noreply, assign(socket, assigns)}
  end

  def handle_event("label_pick", %{"id" => _id, "name" => label_name} = label, socket) do
    assigns = [
      label_search_results: [],
      label_search_phrase: label_name,
      chosen_labels: [input_to_atoms(label)] ++ Map.get(socket.assigns, :chosen_labels, []),
    ]

    {:noreply, assign(socket, assigns)}
  end

  # START EVENT PROXY FUNCTIONS - TODO: find a better approach (hopefully LiveView implements per-input events rather than per-form only)

  def handle_event("label_create" = event, params, socket) do
    debug(proxy_event: event)
    debug(proxy_params: params)
    Bonfire.UI.ValueFlows.CreateLabelLive.handle_event(event, params, socket)
  end

  # END EVENT FUNCTIONS PROXIES
end
