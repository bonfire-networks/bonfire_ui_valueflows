defmodule Bonfire.UI.ValueFlows.AssignedItemLive.LiveHandler do
  use Bonfire.Web, :live_handler

  def handle_event("select", %{"id" => id, "name"=>name} = _attrs, socket) when is_binary(id) do

    {:noreply,
        socket
        |> cast_self(
          assign_to: [{name, id}] |> IO.inspect
        )
    }
  end

  def handle_event("deselect", %{"id" => _deselected} = _attrs, socket) do

    {:noreply,
        socket
        |> cast_self(
          assign_to: []
        )
    }
  end

end
