class UsersController < ApplicationController
  actions :index, :show, :create, :new
  views :index, :show, :new

  def index
    render view: :index,
      locals: locals(user_name: "John Doe", email: "john@example.com", admin: true),
      layout: :application
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
