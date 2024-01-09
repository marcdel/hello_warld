defmodule HelloWarld.Repo do
  use Ecto.Repo,
    otp_app: :hello_warld,
    adapter: Ecto.Adapters.Postgres
end
