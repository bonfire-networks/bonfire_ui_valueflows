defmodule Bonfire.UI.ValueFlows.AssignedItemLive do
  use Bonfire.Web, :stateless_component

  prop is_editable, :boolean, default: false
  prop agent, :any
  prop pick_event, :string
  prop remove_event, :string

  def update(%{is_editable: true} = assigns, socket) do

    agent = e(assigns, :agent, e(assigns, :current_user, nil))

    {:ok, socket
      |> assigns_merge(assigns,
      selected_options: e(assigns, :provider, [{e(agent, :name, e(agent, :profile, :name, nil)), e(agent, :id, nil)}])
      )}
  end

  def update(assigns, socket) do

    {:ok, socket
      |> assign(assigns)}
  end


end
