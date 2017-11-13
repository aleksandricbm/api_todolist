class Comment < ActiveRecord::Base
  belongs_to :task
  mount_base64_uploader :file, ImageUploader
  validate :file_size

  def file_size
    if file.size.to_f/(1000*1000) > 10
      errors.add(:file, "You cannot upload a file greater than #{upload_limit.to_f}MB")
    end
  end
end
