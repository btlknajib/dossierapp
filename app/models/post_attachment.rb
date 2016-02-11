class PostAttachment < ActiveRecord::Base
   mount_uploader :picture, AvatarUploader
   belongs_to :post
end
