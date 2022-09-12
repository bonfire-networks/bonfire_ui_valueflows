defmodule Bonfire.UI.ValueFlows.CreateIntentLive do
  use Bonfire.UI.Common.Web, :stateless_component

  prop intent_url, :string, required: false, default: ""
  prop action, :string, required: false, default: "produce"
  prop output_of_id, :string, required: false
  prop title, :string, default: "Create a new intent"
  prop default_tag, :string
  prop textarea_class, :css_class, required: false
end
