defmodule VoteWeb.LayoutView do
  use VoteWeb, :view
  import Phoenix.Controller, only: [current_path: 2, get_flash: 2]

  @type conn :: Plug.Conn.t

  @class "nav-link"
  @reset_link dgettext("menu", "Reset")
  @signin_link dgettext("menu", "Sign In")
  @signout_link  dgettext("menu", "Sign Out")
  @vote_link  dgettext("menu", "Change Vote")
 
  @doc """
  Creates all the menu links.
  """
  @spec menu_links(conn) :: tuple
  def menu_links(conn) do
    [
      vote_link(conn),
      reset_link(conn),
      auth_link(conn)
    ]
  end

  defp auth_link(conn) do
    if authenticated?(conn) do
      link @signout_link, 
        class: @class, 
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

  defp reset_link(conn) do
    if results_page?(conn) do
    # if results_page?(conn) && authenticated?(conn) do
      link @reset_link, 
        class: @class, 
        method: :delete,
        to: poll_path(conn, :delete)
    else
      ""
    end
  end

  defp vote_link(conn) do
    if results_page?(conn) do
      link @vote_link, class: @class, to: poll_path(conn, :new)
    else
      ""
    end
  end

  defp results_page?(conn) do
    current_path(conn, %{}) === poll_path(conn, :index)
  end

  @doc """
  Checks whether a user is logged in
  """
  @spec authenticated?(conn) :: boolean
  def authenticated?(conn), do: !!conn.assigns.current_user
end
