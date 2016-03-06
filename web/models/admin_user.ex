defmodule Picty.AdminUser do
  use Picty.Web, :model
  alias Comeonin.Bcrypt
  alias Picty.Repo

  schema "admin_users" do
    field :username, :string
    field :password, :string

    timestamps
  end

  @required_fields ~w(username password)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> unique_constraint(:username)
    |> validate_length(:password, min: 4)
    |> encrypt_password
  end

  @doc """
  Creates a changeset intended to be used in the authenticate action.

  It only cast the params (if not empty)  and try to authenticate the user.
  """
  def auth_changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> auth
  end

  defp auth(changeset) do

    if changeset.valid?
        and check_password(changeset.params["username"], changeset.params["password"])
        or !changeset.valid? do
        changeset
    else
        add_error(changeset, :password, "Oops, username and password dont match!")
    end

  end

  defp encrypt_password(changeset) do
    if changeset.valid? do
      put_change(changeset, :password, Bcrypt.hashpwsalt(changeset.params["password"]))
    else
      changeset
    end
  end

  @doc """
  Checks if a username and password matches.
  Even if the user cannot be found, the dummy_checkpw is called to mitigate a brute force

  If no username or password is provided, dummy_checkpw is also called
  """
  def check_password(username, password) when not is_nil(username) and not is_nil(password) do

    user = Repo.one(from u in Picty.AdminUser,
                    where: u.username == ^username,
                    select: u)
    cond do
      user != nil -> Bcrypt.checkpw(password, user.password)
      user == nil -> Bcrypt.dummy_checkpw
    end
  end

  def check_password(username, password) when is_nil(password) or is_nil(username) do
    Bcrypt.dummy_checkpw
  end

end
