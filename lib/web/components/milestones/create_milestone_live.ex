defmodule Bonfire.UI.ValueFlows.CreateMilestoneLive do
  use Bonfire.Web, :live_component

  alias ValueFlows.Process.Processes



  def handle_event("create_milestone", %{"name" => name, "note" => note, "due_date" => due_date}, socket) do

    user = current_user(socket)

      data = %{
        is_public: true,
        name: name,
        note: note
        # due_date: due_date <-- this will fail except we convert the due_date in utc_datetime_usec
      }

      {:ok, process} = Processes.create(user, data)
      debug(process)
    {:noreply, socket}
  end

end
