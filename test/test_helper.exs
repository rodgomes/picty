ExUnit.start

Mix.Task.run "ecto.create", ~w(-r Picty.Repo --quiet)
Mix.Task.run "ecto.migrate", ~w(-r Picty.Repo --quiet)
Ecto.Adapters.SQL.begin_test_transaction(Picty.Repo)

