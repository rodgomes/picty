defmodule Mix.Tasks.Picty do
  defmodule CreateAdminUser do
    use Mix.Task
    alias Picty.AdminUser
    alias Picty.Repo

    @shortdoc "Task to create admin users"
    @moduledoc """
    A simple task to create admin user. For now you have to provide the username
    and password as arguments (which is pretty bad).
    """
    def run(args) do
      if args == [] or length(args) < 2 do
        IO.puts "You should provide username and password as arguments"
      else
        options = parse_args(args)
        changeset = AdminUser.changeset(%AdminUser{}, %{username: options[:username],
                                                        password: options[:password]})
        Repo.start_link
        case Repo.insert(changeset) do
          {:ok, _user} ->
            IO.puts "User created successfully"
          {:error, changeset} ->
            IO.puts "Could not create admin user"
            Enum.each(changeset.errors, fn(error) ->
              case error do
                {key, {message, arguments}} -> IO.puts Enum.join([to_string(key), String.replace(message, "%{count}", Integer.to_string(arguments[:count]))], " ")
                {key, message} -> IO.puts Enum.join([to_string(key), message], " ")
              end
            end)
        end
      end
    end

    defp parse_args(args) do
        {options, _, _} = OptionParser.parse(args,
          switches: [username: :string, password: :string],
          aliases: [u: :username, p: :password]
        )
        options
      end
  end

end
