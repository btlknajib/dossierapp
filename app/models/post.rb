class Post < ActiveRecord::Base
  mount_uploader :pict, AvatarUploader
end
