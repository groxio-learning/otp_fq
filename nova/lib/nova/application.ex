defmodule Nova.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    IO.puts("starting application")

    children = [
      # Starts a worker by calling: Nova.Worker.start_link(arg)
      {Nova.Server, %{name: :yas, initial_value: "42"}},
      {Nova.Server, %{name: :jose, initial_value: "42"}},
      {Nova.Server, %{name: :jorge, initial_value: "42"}}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: :sup]
    Supervisor.start_link(children, opts)
  end
end
