defmodule Bonfire.UI.ValueFlows.FiltersLive do
  use Bonfire.UI.Common.Web, :live_component

  def mount(socket) do
    {:ok,
     socket
     |> assign(selected_tab: "")}
  end
end
