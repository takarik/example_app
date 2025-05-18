require "takarik"
require "log"

# Set log level to DEBUG for development
Log.setup(:debug)

# Define and load routes *before* initializing the application
require "./config/routes.cr"

# Initialize the application (Router instance will be populated)
app = Takarik::Application.new

# # Define routes *after* initializing the application (require controllers first)
# app.router.define do |map|
#   map.get "/", controller: HomeController, action: :index
#   map.get "/show", controller: HomeController, action: :show
#   map.get "/foo", controller: HomeController, action: :foo
#   map.get "/bar", controller: HomeController, action: :bar
#   map.get "/users", controller: UsersController, action: :index
#   map.get "/users/new", controller: UsersController, action: :new
#   map.get "/users/:id", controller: UsersController, action: :show
#   map.post "/users", controller: UsersController, action: :create
# end

# Start the application server
app.run