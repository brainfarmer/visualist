defmodule Visualist.Mixfile do
  use Mix.Project

  def project do
    [app: :visualist,
     version: "0.0.1",
     name: "Visualist",
     source_url: "https://github.com/brainfarmer/visualist",
     elixir: "~> 1.0",
     elixirc_paths: elixirc_paths(Mix.env),
     compilers: [:phoenix] ++ Mix.compilers,
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [mod: {Visualist, []},
     applications: [:phoenix, :phoenix_html, :cowboy, :logger,
                    :phoenix_ecto, :mariaex, :httpoison]]
  end

  # Specifies which paths to compile per environment
  defp elixirc_paths(:test), do: ["lib", "web", "test/support"]
  defp elixirc_paths(_),     do: ["lib", "web"]

  # Specifies your project dependencies
  #
  # Type `mix help deps` for examples and options
  defp deps do
    [{:phoenix, "~> 1.0.3"},
    {:phoenix_ecto, "~> 1.1"},
    {:mariaex, "~> 0.4.2"},
    {:phoenix_html, "~> 2.1"},
    {:phoenix_live_reload, "~> 1.0", only: :dev},
    {:cors_plug, "~> 0.1.3"},
    {:cowboy, "~> 1.0"},
    {:httpoison, "~>0.7"},
    {:exjsx, "~>3.2.0"},
    {:earmark, "~> 0.1", only: :dev},
    {:ex_doc, "~> 0.7", only: :dev}]
  end
end
