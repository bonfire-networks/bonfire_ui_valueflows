defmodule Bonfire.UI.ValueFlows.AssignedItemLive do
  use Bonfire.UI.Common.Web, :stateless_component

  prop is_editable, :boolean, default: false
  prop field_name, :string
  prop agent, :any
  prop pick_event, :string
  prop remove_event, :string
  prop context_id, :string
  prop selected_options, :any

  # FIXME! update no longer works in stateless
  def update(%{is_editable: true} = assigns, socket) do
    agent = e(assigns, :agent, nil)
    # |> IO.inspect
    field_name = e(assigns, :field_name, "agent")

    {:ok,
     socket
     |> assigns_merge(assigns,
       field_name: field_name,
       selected_options:
         e(assigns, field_name, [
           {e(agent, :name, e(agent, :profile, :name, nil)), e(agent, :id, nil)}
         ])
     )}
  end

  def update(assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)}
  end
end
