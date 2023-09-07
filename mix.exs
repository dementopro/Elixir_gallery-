defmodule AlzhmrPhoto.MixProject do
  use Mix.Project

  def project do
    [
      app: :alzhmr_photo,
      version: "0.1.0",
      elixir: "~> 1.12",
      elixirc_paths: elixirc_paths(Mix.env()),
      # scott compilers: [] ++ Mix.compilers(),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps()
    ]
  end
  # old   compilers: [:gettext] ++ Mix.compilers(),

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {AlzhmrPhoto.Application, []},
      extra_applications: [:logger, :runtime_tools]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:phoenix, "~> 1.7.0", override: true},
    {:phoenix_live_view, "~> 0.18.3"},
    {:phoenix_live_dashboard, "~> 0.7.2"},
     # {:phoenix, "~> 1.6.9"},
      # scott {:phoenix_ecto, "~> 4.4"},
      #scott {:ecto_sql, "~> 3.6"},
     #scott  {:postgrex, ">= 0.0.0"},
      {:phoenix_html, "~> 3.0"},
      {:phoenix_live_reload, "~> 1.2", only: :dev},
       {:phoenix_view, "~> 2.0"}, #scot new
      #{:phoenix_live_view, "~> 0.17.5"},
      {:floki, ">= 0.30.0", only: :test},
      # scott {:phoenix_live_dashboard, "~> 0.6"},
      {:esbuild, "~> 0.4", runtime: Mix.env() == :dev},
      {:swoosh, "~> 1.3"},
      {:telemetry_metrics, "~> 0.6"},
      {:telemetry_poller, "~> 1.0"},
      {:gettext, "~> 0.18"},
      {:jason, "~> 1.2"},
      {:plug_cowboy, "~> 2.5"},
      {:credo, "~> 1.6", only: [:dev, :test], runtime: false},
      {:tesla, "~> 1.3"},
      {:hackney, "~> 1.16.0"},
      {:tailwind, "~> 0.1", runtime: Mix.env() == :dev},
      {:ssl_verify_fun, "~> 1.1.7", manager: :rebar3, override: true}

    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to install project dependencies and perform other setup tasks, run:
  #
  #     $ mix setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      setup: ["deps.get", "ecto.setup"],
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      test: ["ecto.create --quiet", "ecto.migrate --quiet", "test"],
      "assets.deploy": [ "tailwind default --minify","esbuild default --minify", "phx.digest"]
    ]
  end
end
