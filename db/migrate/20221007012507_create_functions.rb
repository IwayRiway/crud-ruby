class CreateFunctions < ActiveRecord::Migration[7.0]
  def change
    create_table :functions do |t|
      t.references :menu, null: false, foreign_key: true
      t.string :name
      t.string :action

      t.timestamps
    end
  end
end
