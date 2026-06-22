defmodule Bonfire.UI.ValueFlows.CreateIntentLive do
  use Bonfire.UI.Common.Web, :stateless_component

  prop intent_url, :string, required: false, default: ""
  prop action, :string, required: false, default: "produce"
  prop in_scope_of, :string, required: false
  prop output_of_id, :string, required: false
  prop name_prompt, :string, default: nil
  prop process_prompt, :string, default: nil
  prop default_tag, :string, default: nil

  prop smart_input_opts, :map, default: %{}
  prop textarea_class, :css_class, required: false

  prop to_boundaries, :any, default: nil
  prop open_boundaries, :boolean, default: false

  @behaviour Bonfire.UI.Common.SmartInputModule
  def smart_input_module, do: [:intent, :offer, :need, ValueFlows.Planning.Intent]

  def smart_input_icon(_), do: "ph:handshake-duotone"

  def smart_input_label(:offer), do: l("Offer")
  def smart_input_label(:need), do: l("Need")
  def smart_input_label(_), do: l("Intent")
end
