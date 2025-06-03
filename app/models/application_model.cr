require "takarik-data"
require "sqlite3"

class ApplicationModel < Takarik::Data::BaseModel
  # Setup database connection for Takarik::Data
  Takarik::Data.establish_connection(ENV["DATABASE_URL"]? || "sqlite3:./db/development.db")
end
