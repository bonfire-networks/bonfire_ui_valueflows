defmodule Bonfire.UI.ValueFlows.CreateLabelLive do
  use Bonfire.UI.Common.Web, :live_component

  def mount(socket) do
    {:ok,
     socket
     |> assign(
       label_search_results: [],
       label_search_phrase: ""
     )}
  end

  def do_handle_event("label_create", %{"label_input" => label_entered}, socket) do
    assigns =
      with {:ok, label} <-
             Bonfire.Classify.Categories.create(current_user_required!(socket), %{
               name: label_entered
             }) do
        [
          label_search_results: [],
          label_search_phrase: "",
          chosen_labels:
            [repo().preload(label, :profile)] ++
              Map.get(socket.assigns, :chosen_labels, [])
        ]
      else
        e ->
          debug(error: e)
          []
      end

    {:noreply, assign(socket, assigns)}
  end
end
