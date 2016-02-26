defmodule Picty.AdminUser do
  use Picty.Web, :model
  alias Comeonin.Bcrypt

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

  def encrypt_password(changeset) do
    if changeset.params["password"] do
      put_change(changeset, :password, Bcrypt.hashpwsalt(changeset.params["password"]))
    else
      changeset
    end
  end


end
