defmodule Bonfire.UI.ValueFlows.SelectProcessLive do
  use Bonfire.UI.Common.Web, :stateless_component

  prop is_editable, :boolean, default: false
  prop field_name, :string
  prop pick_event, :string
  prop remove_event, :string, default: nil
  prop context_id, :string
  prop selected_options, :any
  prop class, :css_class, required: false
end
