defmodule Bonfire.UI.ValueFlows.AssignItemLive do
  use Bonfire.UI.Common.Web, :stateless_component

  prop is_editable, :boolean, default: false
  prop field_name, :string, required: true
  prop agent, :any, default: nil
  prop pick_event, :string, default: nil
  prop remove_event, :string, default: nil
  prop context_id, :string, default: nil
  prop selected_options, :list, default: nil
  prop event_target, :any, default: nil
  prop class, :css_class, default: nil

  def selected_options(selected_options, field_name, agent, context) do
    selected_options || e(context, field_name, nil) || agent
  end
end
