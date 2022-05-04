defmodule Bonfire.UI.ValueFlows.CreateIntentLive do
  use Bonfire.UI.Common.Web, :stateless_component

  prop intent_url, :string, required: false, default: ""
  prop action, :string, required: false
  prop output_of_id, :string, required: false
  prop title, :string, default: "Create a new intent"
  prop default_tag, :string
end
