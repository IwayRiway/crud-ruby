class CreateTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks do |t|
      t.references :todo_list, null: false, foreign_key: true
      t.string :name
      t.boolean :completed
      t.date :due

      t.timestamps
    end
  end
end
