defmodule Bonfire.UI.ValueFlows.CreateEconomicEventLive do
  use Bonfire.UI.Common.Web, :stateless_component

  prop action, :string, required: true
  prop remove, :string, required: true
  prop input_of_id, :string
  prop output_of_id, :string
  prop units, :list
  prop changeset, :any
  prop form_error, :string, default: ""
  prop extra_components, :list

  prop provider, :any, default: nil
  prop receiver, :any, default: nil

  prop users_autocomplete, :any, default: nil

  prop economic_resources_autocomplete, :any, default: nil
  prop economic_resource_selected, :any, default: nil

  prop geolocation_autocomplete, :any, default: nil
  prop geolocation_selected, :any, default: nil

  prop resource_specifications_autocomplete, :any, default: nil
  prop resource_specification_selected, :any, default: nil

  prop pick_event, :any, default: nil
  prop remove_event, :any, default: nil

  def mount(socket) do
    {:ok,
     socket
     |> assign(
       form_error: "",
       changeset: ValueFlows.EconomicEvent.validate_changeset()
     )}
  end
end
