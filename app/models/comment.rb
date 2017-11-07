class Comment < ActiveRecord::Base
  belongs_to :task
  mount_base64_uploader :file, ImageUploader
end
