defmodule Bonfire.UI.ValueFlows.ResourceItemLive do
  use Bonfire.UI.Common.Web, :stateless_component

  prop resource_url_prefix, :string
  prop resource, :map
end
