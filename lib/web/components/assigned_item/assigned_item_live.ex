defmodule Bonfire.UI.ValueFlows.AssignedItemLive do
  use Bonfire.Web, :stateless_component

  prop is_editable, :boolean, default: false
  prop object_id, :string
  prop agent, :any
  prop pick_event, :string, default: "Bonfire.UI.ValueFlows.AssignedItemLive:select"
  prop remove_event, :string, default: "Bonfire.UI.ValueFlows.AssignedItemLive:deselect"

  def update(%{is_editable: true} = assigns, socket) do
    IO.inspect(assigns)

    current_user = e(assigns, :current_user, nil)

    followed = if current_user, do: Bonfire.Social.Follows.list_followed(current_user) #|> IO.inspect
    |> Enum.map(&follow_to_tuple/1), else: []

    # IO.inspect(followed)

    preloaded_options = [{e(current_user, :profile, :name, "Me"), e(current_user, :id, "me")}] ++ followed

    {:ok, socket
      |> assigns_merge(assigns,
      preloaded_options: preloaded_options,
      selected_options: e(assigns, :assign_to, [{e(assigns, :agent, :name, e(assigns, :agent, :profile, :name, nil)), e(assigns, :agent, :id, nil)}])
      )}
  end

  def update(assigns, socket) do

    {:ok, socket
      |> assign(assigns)}
  end

  def follow_to_tuple(%{followed_profile: profile}) do
    {profile.name, profile.id}
  end
  def follow_to_tuple(%{follower_profile: profile}) do
    {profile.name, profile.id}
  end


end
