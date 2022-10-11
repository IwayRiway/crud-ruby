class CreateProductReceivingItems < ActiveRecord::Migration[7.0]
  def change
    create_table :product_receiving_items do |t|
      t.references :product_receiving, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
      t.integer :quantity
      t.integer :status

      t.timestamps
    end
  end
end
