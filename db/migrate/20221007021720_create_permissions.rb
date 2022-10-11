class CreatePermissions < ActiveRecord::Migration[7.0]
  def change
    create_table :permissions do |t|
      t.references :user, null: false, foreign_key: false
      t.references :function, null: false, foreign_key: false

      t.timestamps
    end
  end
end
