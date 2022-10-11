class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :part_id
      t.string :part_name
      t.integer :status

      t.timestamps
    end
  end
end
