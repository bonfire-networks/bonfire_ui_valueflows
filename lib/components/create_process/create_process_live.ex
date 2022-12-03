defmodule Bonfire.UI.ValueFlows.CreateProcessLive do
  use Bonfire.UI.Common.Web, :stateless_component

  prop close, :string
  prop process_url, :string

  prop textarea_class, :css_class, required: false
  # unused but workaround surface "invalid value for property" issue
  prop textarea_container_class, :css_class

  prop to_boundaries, :any, default: nil
  prop open_boundaries, :boolean, default: false
end
