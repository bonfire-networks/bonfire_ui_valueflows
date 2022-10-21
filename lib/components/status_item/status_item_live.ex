defmodule Bonfire.UI.ValueFlows.StatusItemLive do
  use Bonfire.UI.Common.Web, :stateless_component

  prop status, :string, required: true
  prop is_editable, :boolean, required: true
end
