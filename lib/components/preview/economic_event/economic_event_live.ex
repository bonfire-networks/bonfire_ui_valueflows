defmodule Bonfire.UI.ValueFlows.Preview.EconomicEventLive do
  use Bonfire.UI.Common.Web, :stateless_component

  prop activity, :any, default: nil
  prop object, :map

  # what the activity was for whoever is reading it, from `Bonfire.Social.Activities.experienced_as/2`. An economic event is a `:create` whose word is the action it records, which `Activities.experience_display/2` reads off the object
  prop experienced_as, :atom, default: nil

  # @resource_preloads [
  #   :image,
  #   :current_location,
  #   onhand_quantity: [:unit],
  #   accounting_quantity: [:unit]
  # ]

  def preloads() do
    resource_preloads = Bonfire.UI.ValueFlows.Preview.EconomicResourceLive.preloads()

    [
      :input_of,
      :output_of,
      provider: [:character, profile: [:icon]],
      receiver: [:character, profile: [:icon]],
      resource_quantity: [:unit],
      effort_quantity: [:unit],
      resource_inventoried_as: resource_preloads,
      to_resource_inventoried_as: resource_preloads
    ]
  end

  def activity_component(object) do
    object = prepare(object)

    {__MODULE__, [object: object]}
  end

  def prepare(object) do
    object
    # |> debug("event")
    |> maybe_to_struct(ValueFlows.EconomicEvent)
    # |> debug("struct")
    |> preload()
  end

  defp preload(object) do
    object
    |> repo().maybe_preload(preloads())
    |> maybe_preload_action()
  end

  def maybe_preload_action(object) do
    if module_enabled?(ValueFlows.EconomicEvent.EconomicEvents),
      do: ValueFlows.EconomicEvent.EconomicEvents.preload_action(object),
      else: object
  end
end
