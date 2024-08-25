defmodule Bonfire.UI.ValueFlows.RuntimeConfig do
  use Bonfire.Common.Localise
  alias Bonfire.Common.Utils
  use Bonfire.Common.E

  @behaviour Bonfire.Common.ConfigModule
  def config_module, do: true

  @doc """
  NOTE: you can override this default config in your app's `runtime.exs`, by placing similarly-named config keys below the `Bonfire.Common.Config.LoadExtensionsConfig.load_configs()` line
  """
  def config do
    import Config

    # config :bonfire_ui_valueflows,
    #   modularity: :disabled

    config :bonfire, :ui,
      activity_preview: [],
      object_preview: [
        {ValueFlows.EconomicEvent,
         &Bonfire.UI.ValueFlows.Preview.EconomicEventLive.activity_component/1},
        {ValueFlows.EconomicResource, Bonfire.UI.ValueFlows.Preview.EconomicResourceLive},
        # TODO: choose between Task and other Intent types
        {ValueFlows.Planning.Intent, Bonfire.UI.ValueFlows.Preview.IntentTaskLive},
        {ValueFlows.Process, &Bonfire.UI.ValueFlows.Preview.ProcessListLive.activity_component/1}
      ],
      object_actions: [
        {ValueFlows.EconomicEvent,
         {Bonfire.UI.ValueFlows.Preview.EventActionsLive,
          fn activity ->
            %{
              object:
                e(activity, :object, :resource_inventoried_as, nil) ||
                  e(activity, :object, nil)
            }
          end}}
        # {ValueFlows.Planning.Intent, []},
        # {ValueFlows.Process, []},
        # {ValueFlows.EconomicResource, []}
      ]
  end
end
