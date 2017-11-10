class CreateTasks < ActiveRecord::Migration[5.1]
  def change
    create_table :tasks do |t|
      t.string :name, null: false
      t.datetime :deadline
      t.belongs_to :project, foreign_key: true
      t.integer :position, default: 0
      t.boolean :completed, default: false
      t.timestamps
    end
  end
end
