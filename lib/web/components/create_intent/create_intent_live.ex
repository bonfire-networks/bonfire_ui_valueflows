defmodule Bonfire.UI.ValueFlows.CreateIntentLive do
  use Bonfire.Web, :stateless_component

  prop intent_url, :string, required: false, default: ""
  prop action, :string, required: false
  prop output_of_id, :string, required: false
  prop provider_id, :string, required: false

end
