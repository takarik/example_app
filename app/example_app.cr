require "takarik"
require "log"

# Set log level to DEBUG for development
Log.setup(:debug)

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

app = Takarik::Application.new

# Start the application server
app.run
