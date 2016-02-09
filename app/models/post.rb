class Post < ActiveRecord::Base
  mount_uploader :pict, AvatarUploader
  belongs_to :user
end
