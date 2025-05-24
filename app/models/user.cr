class User < Granite::Base
  include BaseModel

  table users

  column id : Int64, primary: true
  column name : String
  timestamps

  has_many posts : Post
end
