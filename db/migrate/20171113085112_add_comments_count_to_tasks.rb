class AddCommentsCountToTasks < ActiveRecord::Migration[5.1]
  def change
    add_column :tasks, :comments_qty, :integer, default: 0
  end
end
