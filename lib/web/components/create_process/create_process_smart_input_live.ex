defmodule Bonfire.UI.ValueFlows.CreateProcessSmartInputLive do
  use Bonfire.UI.Common.Web, :stateless_component

  prop process_url, :string, default: "/process/"
  prop textarea_class, :css_class, required: false

end
