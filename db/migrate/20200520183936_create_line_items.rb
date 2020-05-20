class CreateLineItems < ActiveRecord::Migration[5.2]
  def change
    create_table :line_items do |t|
      t.string :code
      t.integer :quantity, default: 0
      t.decimal :price, precision: 10, scale: 2, default: 0.00
      t.decimal :total, precision: 10, scale: 2, default: 0.00
      t.references :cart, foreign_key: true

      t.timestamps
    end
  end
end
