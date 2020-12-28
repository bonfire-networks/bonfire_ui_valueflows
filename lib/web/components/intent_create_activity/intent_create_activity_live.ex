defmodule Bonfire.UI.ValueFlows.IntentCreateActivityLive do
  use Bonfire.Web, :live_component

  def mount(socket) do
    {:ok, socket
    |> assign(selected_tab: "")}
  end


  def handle_event("toggleProposal", %{"id" => id}, socket) do

     socket = assign(socket, selected_tab: id)

     {:noreply, socket}
  end
end
