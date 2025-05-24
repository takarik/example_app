require "takarik"
require "log"
require "granite"
require "granite/adapter/sqlite"

# Set log level to DEBUG for development
Log.setup(:debug)

# Setup database connection for Granite
Granite::Connections << Granite::Adapter::Sqlite.new(
  name: "primary",
  url: ENV["DATABASE_URL"]? || "sqlite3:./db/development.db"
)

# Load models
require "./models/*"

# Define and load routes
require "./config/routes.cr"

# Initialize the application (Router instance will be populated)
app = Takarik::Application.new

# Start the application server
app.run