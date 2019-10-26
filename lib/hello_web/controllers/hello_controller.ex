defmodule HelloWeb.HelloController do
  use HelloWeb, :controller
  alias HelloWeb.Router.Helpers, as: Routes
  alias Hello.User
 alias Hello.Repo

  def index(conn, _params) do
    show = Repo.all(User)
    render(conn, "index.html", show: show)
  end


  def show(conn, %{"id" => id}) do
    show1 = Repo.get(User,id)
    render(conn, "show.html", show: show1)
  end

  def new(conn, _params) do
    changeset = User.changeset(%User{},%{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user" => user}) do
    changeset = User.changeset(%User{}, user)
    case Repo.insert(changeset) do
      {:ok,user} ->
      conn
      |> put_flash(:info, "User has been Ceated")
      |> redirect(to: Routes.hello_path(conn, :index))
      {:error,changeset} ->
      render(conn, "new.html", changeset: changeset)
    end
  end

  def edit(conn, %{"id" => id}) do
    edit_user = Repo.get(User, id)
    changeset = User.changeset(edit_user, %{})
    render(conn, "edit.html",  changeset: changeset, edit_user: edit_user)
  end

  def update(conn, %{"id" => id, "user" => user}) do
    user_id = Repo.get(User, id)
    changeset = User.changeset(user_id, user)
    case Repo.update(changeset) do
      {:ok,user} ->
      conn
        |> put_flash(:info, "User Updated Successfully")
        |> redirect(to: Routes.hello_path(conn, :index))
      {:error,changeset} ->
      conn
        |> put_flash(:error, "User Not Updated")
        render(conn, "edit.html", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    u_del = Repo.get(User,id)
    case Repo.delete(u_del) do
      {:ok,user} ->
        conn
        |> put_flash(:info, "User Deleted Successfully")
        |> redirect(to: Routes.hello_path(conn, :index))
      {:error,changeset} ->
      conn
        |> put_flash(:error, "User Not Deleted")
        render(conn, "index.html")
    end
  end


  #def show(conn, %{"messenger" => messenger, "id" => id}) do
    #render(conn, "show.html", msg: messenger, id: id)
  #end

  #def show(conn, _params) do
  #show = Repo.all(User)
  #render(conn, "show.html", show: show)
  #end

end

