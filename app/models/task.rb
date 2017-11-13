class Task < ActiveRecord::Base
  belongs_to :project
  has_many :comments, dependent: :destroy
  before_create :set_position

  default_scope { order("position ASC") }

  def set_position
    max = self.project.tasks.maximum(:position)
    self.position = max.nil? ? 0 : max + 1
  end

  def set_completed
    self.completed = self.completed? ? false : true
    self.save
  end

  def set_deadline(data)
    self.deadline = data
    self.save
  end

  def increase_comments_qty
    self.comments_qty +=1
    self.save
  end
end
