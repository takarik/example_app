class Post < Granite::Base
  include BaseModel

  table posts

  column id : Int64, primary: true
  column title : String
  column content : String
  column user_id : Int64
  timestamps

  belongs_to user : User
end
