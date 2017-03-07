defmodule Web do
  @moduledoc """
  Documentation for Web.
  """

  use Application
  require Logger

  @module __MODULE__
  
  @doc """
  """
  def start(_type, _args) do
    children = [
      Plug.Adapters.Cowboy.child_spec(:http, Web.Router, [], port: 8080)
    ]

    Logger.info("#{@module}: Started on port 8080")

    Supervisor.start_link(children, strategy: :one_for_one)
  end
  
end
