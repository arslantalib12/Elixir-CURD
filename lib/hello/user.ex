defmodule Hello.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :email, :string
    field :name, :string
    field :no_of_pets, :integer

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :email, :no_of_pets])
    |> validate_required([:name, :email])
    |> validate_format(:email, ~r/@/)
  end
end
