defmodule Slots.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Starts a worker by calling: Slots.Game.start_link(arg)
      # {Slots.Game, :bruce}
      %{id: :bruce, start: {Slots.Game, :start_link, [:bruce]}},
      %{id: :jose, start: {Slots.Game, :start_link, [:jose]}},
      %{id: :jorge, start: {Slots.Game, :start_link, [:jorge]}},
      %{id: :yas, start: {Slots.Game, :start_link, [:yas]}},
      %{id: :eduardo, start: {Slots.Game, :start_link, [:eduardo]}},
      %{id: :ahmed, start: {Slots.Game, :start_link, [:ahmed]}}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_all, name: :sup]
    Supervisor.start_link(children, opts)
  end
end
