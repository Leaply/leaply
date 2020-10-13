defmodule LeaplyWeb.LandingPageController do
  use LeaplyWeb, :controller

  def home(conn, _params) do
    render(conn, "home.html",
      page_title: "Home",
      users: 2000 + :rand.uniform(1000),
      listings: 18,
      companies: 12,
      placements: 658
    )
  end
end
