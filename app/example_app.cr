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

# Configure static file serving
Takarik.configure do |config|
  config.static_files(
    public_dir: "./public",
    cache_control: "public, max-age=3600",
    enable_etag: true,
    enable_last_modified: true
  )
end

# Define and load routes
require "./config/routes.cr"

# Initialize the application (Router instance will be populated)
# Use PORT environment variable for Heroku compatibility
port = ENV["PORT"]?.try(&.to_i) || 3000
app = Takarik::Application.new(host: "0.0.0.0", port: port)

# Start the application server
app.run