import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :hello_warld, HelloWarld.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "hello_warld_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :hello_warld, HelloWarldWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "tj6MrUED/3ZWnd4u0rWQU9Oa0MF/H6lK6+r3BLS93RAaoCjdTxHkoty8fDHEpt8G",
  server: false

# In test we don't send emails.
config :hello_warld, HelloWarld.Mailer, adapter: Swoosh.Adapters.Test

# Disable swoosh api client as it is only required for production adapters.
config :swoosh, :api_client, false

# Print only warnings and errors during test
config :logger, level: :warning

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
