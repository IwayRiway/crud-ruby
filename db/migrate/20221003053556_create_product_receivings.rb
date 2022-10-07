class CreateProductReceivings < ActiveRecord::Migration[7.0]
  def change
    create_table :product_receivings do |t|
      t.string :document_number
      t.date :document_date
      t.integer :status

      t.timestamps
    end
  end
end
