class Comment < ApplicationRecord
  belongs_to :task, counter_cache: true
  mount_base64_uploader :file, ImageUploader
  validates :comment, presence: true, length: { minimum: 10, maximum: 256 }
  validate :file_size

  def file_size
    errors.add(:file, "long") if file.size.to_f / (1000 * 1000) > 10
  end
end
