class OrdersLineItem < ApplicationRecord
  belongs_to :order
  belongs_to :line_item

  validates :order_id, :line_item_id, presence: true
end
