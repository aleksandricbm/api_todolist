class AddUniqueIndexToProject < ActiveRecord::Migration[5.1]
  def change
    add_index :projects, [:user_id, :name], unique: true
  end
end
