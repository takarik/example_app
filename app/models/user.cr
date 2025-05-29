class User < ApplicationModel
  column :name, String
  timestamps

  has_many :posts, class_name: "Post"
end
