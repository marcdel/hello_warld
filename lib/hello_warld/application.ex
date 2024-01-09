defmodule HelloWarld.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      HelloWarldWeb.Telemetry,
      HelloWarld.Repo,
      {DNSCluster, query: Application.get_env(:hello_warld, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: HelloWarld.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: HelloWarld.Finch},
      # Start a worker by calling: HelloWarld.Worker.start_link(arg)
      # {HelloWarld.Worker, arg},
      # Start to serve requests, typically the last entry
      HelloWarldWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: HelloWarld.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    HelloWarldWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
