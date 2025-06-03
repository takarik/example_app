class UsersController < ApplicationController
  actions :index, :show, :create, :new, :list
  views :index, :show, :new

  @users : Array(User)?

  def index
    @users = User.inner_join("posts").to_a
    render layout: :application
  end

  def list
    @users = User.all.to_a
    render json: @users
  end

  def show
    id = params["id"]?.try(&.as_s) || "1"
    user_name = params["username"]?.try(&.as_s) || "Guest"
    email = params["email"]?.try(&.as_s) || "guest@example.com"
    admin = params["admin"]?.try(&.as_bool) || false

    render locals: locals(id: id, user_name: user_name, email: email, admin: admin),
      layout: :application
  end

  def new
    @user = "New user"
    render layout: :application
  end

  def create
    # Simulate creating a user
    user_data = {
      id:    1,
      name:  params["name"]?.try(&.as_s) || "Anonymous",
      email: params["email"]?.try(&.as_s) || "example@example.com",
    }

    render json: user_data
  end
end
