defmodule Leaply.Repo do
  use Ecto.Repo,
    otp_app: :leaply,
    adapter: Ecto.Adapters.Postgres
end
