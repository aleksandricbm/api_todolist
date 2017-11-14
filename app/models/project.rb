class Project < ApplicationRecord
  belongs_to :user
  has_many :tasks, dependent: :destroy

  validates :name, presence: true
  validate :uniques_project

  def uniques_project
    errors.add(:uniques_project, I18n.t('errors.uniques_project')) if user.projects.where(name: self.name).exists?
  end

end
