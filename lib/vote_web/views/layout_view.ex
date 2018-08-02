defmodule VoteWeb.LayoutView do
  use VoteWeb, :view
  # import Phoenix.Controller, only: [current_path: 2]

  @type conn :: Plug.Conn.t

  @signin_link dgettext("menu", "Sign In")
  @signout_link  dgettext("menu", "Sign Out")
  # @vote_link  dgettext("menu", "Vote")
 
  @doc """
  Creates all the menu links.
  """
  @spec menu_links(conn) :: tuple
  def menu_links(conn) do
    if authenticated?(conn) do
      link @signout_link, 
        class: "nav-link",
        method: :delete,
        to: auth_path(conn, :delete)
    else
      link @signin_link, 
        class: "nav-link",
        data_toggle: "modal",
        data_target: "#loginModal",
        to: "#"
    end
  end

  # defp link(conn, text, path) do
  #   class = if current_path(conn, %{}) === path, 
  #     do: "nav-link active", else: "nav-link"
  #   link text, to: path, class: class
  # end

  @doc """
  Checks whether a user is logged in
  """
  @spec authenticated?(conn) :: boolean
  def authenticated?(conn), do: !!conn.assigns.current_user
end
