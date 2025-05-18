class UsersController < ApplicationController
  actions :index, :show, :create, :new
  views :index, :show, :new

  def index
    render view: :index, locals: {
      "user_name" => JSON::Any.new("John Doe"),
      "email"     => JSON::Any.new("john@example.com"),
      "admin"     => JSON::Any.new(true),
    }
  end

  def show
    id = params["id"]?.try(&.as_s) || "1"
    user_name = params["username"]?.try(&.as_s) || "Guest"
    email = params["email"]?.try(&.as_s) || "guest@example.com"
    admin = params["admin"]?.try(&.as_bool) || false

    render locals: {
      "id"        => JSON::Any.new(id),
      "user_name" => JSON::Any.new(user_name),
      "email"     => JSON::Any.new(email),
      "admin"     => JSON::Any.new(admin),
    }
  end

  def new
    render
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
