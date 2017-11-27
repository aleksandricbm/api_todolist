class Task < ApplicationRecord
  belongs_to :project
  validates :name, presence: true
  has_many :comments, dependent: :destroy
  before_create :set_position

  default_scope { order('position ASC') }
  acts_as_list scope: :project
end
