class AddTotalToOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :total, :decimal, precision: 10, scale: 2, default: 0.00
  end
end
