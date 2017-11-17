class Task < ApplicationRecord
  belongs_to :project
  validates :name, presence: true
  has_many :comments, dependent: :destroy
  before_create :set_position

  default_scope { order('position ASC') }
  acts_as_list scope: :project

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

  # def increase_comments_qty
  #   self.comments_qty += 1
  #   self.save
  # end

  # def decrease_comments_qty
  #   self.comments_qty -= 1 if self.comments_qty > 0
  #   self.save
  # end

  def move_position(direction)
    case direction
      when 'up' then self.move_higher
      when 'down' then self.move_lower
      else false
    end
  end

  def update_params(params)
    move_position(params[:direction]) if params[:direction].present?
    update_attributes(params.require(:task).permit(:name)) if params[:name].present?
    set_completed if params[:completed].present?
    set_deadline(params[:deadline]) if params[:deadline].present?
  end
end
