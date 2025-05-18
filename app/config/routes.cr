# Define application routes using the Takarik router DSL
require "../controllers/*"
require "log"

Log.debug { "Defining routes..." }

Takarik::Router.define do |map|
  map.get "/", controller: HomeController, action: :index
  map.get "/show", controller: HomeController, action: :show
  map.get "/foo", controller: HomeController, action: :foo
  map.get "/bar", controller: HomeController, action: :bar
  map.get "/users", controller: UsersController, action: :index
  map.get "/users/new", controller: UsersController, action: :new
  map.get "/users/:id", controller: UsersController, action: :show
  map.post "/users", controller: UsersController, action: :create
end

Log.debug { "Routes defined." }