require "takarik"
require "log"

# Set log level to DEBUG for development
Log.setup(:debug)

# Define and load routes *before* initializing the application
require "./config/routes.cr"

# Initialize the application (Router instance will be populated)
app = Takarik::Application.new

# Start the application server
app.run