class Post < ApplicationModel
  column :title, String
  column :content, String
  timestamps

  belongs_to :user, class_name: "User"
end
