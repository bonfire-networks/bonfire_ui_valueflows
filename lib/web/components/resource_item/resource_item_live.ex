defmodule Bonfire.UI.ValueFlows.ResourceItemLive do
  use Bonfire.Web, :stateless_component

  prop resource_url_prefix, :string
  prop resource, :map
end
