defmodule Bonfire.UI.ValueFlows.EditDescriptionLive do
  use Bonfire.UI.Common.Web, :stateless_component

  prop item, :map
  prop submit_event, :any, default: nil
  prop is_editable?, :boolean, default: true
end
