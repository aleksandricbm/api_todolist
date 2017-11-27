class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.text :comment, length: { minimum: 10, maximum: 256 }
      t.string :file
      t.belongs_to :task, foreign_key: true

      t.timestamps
    end
  end
end
