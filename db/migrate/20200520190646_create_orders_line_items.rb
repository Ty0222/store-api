class CreateOrdersLineItems < ActiveRecord::Migration[5.2]
  def change
    create_table :orders_line_items do |t|
      t.references :order, foreign_key: true
      t.references :line_item, foreign_key: true

      t.timestamps
    end
  end
end
