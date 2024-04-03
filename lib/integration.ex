defmodule Bonfire.UI.ValueFlows.Integration do
  use Bonfire.Common.Utils

  declare_extension("Common UI components for ValueFlows",
    icon: "fluent-mdl2:web-components",
    emoji: "🧩",
    description: l("Reusable user interface components for other ValueFlows extensions.")
  )

  def repo, do: Bonfire.Common.Config.repo()

  def mailer, do: Bonfire.Common.Config.get!(:mailer_module)
end
