module Update_task
  extend ActiveSupport::Concern

  included do
    def set_completed
      @task.completed = @task.completed? ? false : true
      @task.save
    end

    def set_deadline(data)
      @task.deadline = data
      @task.save
    end

    def move_position(direction)
      case direction
        when 'up' then @task.move_higher
        when 'down' then @task.move_lower
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
end
