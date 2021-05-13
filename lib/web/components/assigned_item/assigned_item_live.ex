defmodule Bonfire.UI.ValueFlows.AssignedItemLive do
  use Bonfire.Web, :stateless_component

  prop is_editable, :boolean, default: false
  prop field_name, :string
  prop agent, :any
  prop pick_event, :string
  prop remove_event, :string

  def update(%{is_editable: true} = assigns, socket) do

    agent = e(assigns, :agent, e(assigns, :current_user, nil))
    field_name = e(assigns, :field_name, "agent")

    {:ok, socket
      |> assigns_merge(assigns,
      field_name: field_name,
      selected_options: e(assigns, field_name, [{e(agent, :name, e(agent, :profile, :name, nil)), e(agent, :id, nil)}])
      )}
  end

  def update(assigns, socket) do

    {:ok, socket
      |> assign(assigns)}
  end


end
