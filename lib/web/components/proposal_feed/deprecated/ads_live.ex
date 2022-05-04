defmodule Bonfire.Web.Component.AdsPreviewLive do
  use Bonfire.UI.Common.Web, :live_component

  # import CommonsPub.Profiles.Web.ProfilesHelper
  # def mount(_, _session, socket) do
  #   {:ok, assign(socket, current_user: current_user(socket))}
  # end

  def update(assigns, socket) do
    ads = CommonsPub.Profiles.Web.ProfilesHelper.prepare(assigns.ads, %{image: true})

    {:ok,
     socket
     |> assign(
       ads: ads |> Map.merge(%{created_at: date_from_now(ads.published_at)})
       #  current_user: current_user(assigns)
     )}
  end

  def render(assigns) do
    ~L"""
    <%=
      live_redirect to: "/!"<> e(@ads, :character, :preferred_username, "deleted") do %>
      <div class="ads__preview">
        <div class="preview__image" style="background-image: url(e(@ads, :image, ""))"></div>
        <div class="preview__info">
          <h4><%= e(@ads, :name, "Intent") %></h4>
          <span class="info__meta">Published <%= e(@ads, :created_at, "one day") %></span>
          <div class="info__note"><%= e(@ads, :note, "") %></div>
        </div>
      </div>
    <% end %>
    """
  end
end
