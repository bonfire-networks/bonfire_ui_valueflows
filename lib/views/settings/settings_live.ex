defmodule Bonfire.UI.ValueFlows.SettingsLive do
  use Bonfire.UI.Common.Web, :live_view

  use AbsintheClient,
    schema: Bonfire.API.GraphQL.Schema,
    action: [mode: :internal]

  alias Bonfire.UI.ValueFlows.CreateUnitLive
  alias Bonfire.UI.ValueFlows.CreateValueCalculationLive
  alias Bonfire.UI.ValueFlows.CreateResourceSpecificationLive

  on_mount {LivePlugs, [Bonfire.UI.Me.LivePlugs.LoadCurrentUser]}

  def mount(params, session, socket) do
    settings_queries = settings_queries(socket)

    {:ok,
     assign(
       socket,
       page_title: l("Settings"),
       all_units: e(settings_queries, :units_pages, :edges, []),
       all_resources: e(settings_queries, :resource_specifications_pages, :edges, []),
       all_value_calculations: e(settings_queries, :value_calculations_pages, :edges, []),
       actions: e(settings_queries, :actions, [])
     )}
  end

  def handle_info({:add_unit, unit}, socket) do
    {:noreply,
     socket
     |> assign(all_units: [unit] ++ socket.assigns.all_units)
     |> assign_flash(:info, "Unit successfully created!")}
  end

  def handle_info({:add_resource_specification, resource}, socket) do
    {:noreply,
     socket
     |> assign(all_units: [resource] ++ socket.assigns.all_resources)
     |> assign_flash(:info, "Resource specification successfully created!")}
  end

  def handle_info({:add_vc, vc}, socket) do
    {:noreply,
     socket
     |> assign_flash(:info, "Value calculation successfully created!")
     |> assign(all_value_calculations: [vc] ++ socket.assigns.all_value_calculations)}
  end

  @graphql """
    {
      units_pages(limit: 100) {
        edges {
          id
          label
          symbol
        }
      }
      actions {
        id
        label
      }
      resource_specifications_pages(limit: 100) {
        edges {
          id
          note
          name
          default_unit_of_effort {
            label
            id
          }
        }
      }
      value_calculations_pages(limit: 100) {
         edges {
          id
          note
          name
         }
      }
    }
  """

  def settings_queries(params \\ %{}, socket),
    do: liveql(socket, :settings_queries, params)
end
