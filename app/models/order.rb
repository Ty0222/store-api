class Order < ApplicationRecord
  has_many :orders_line_items
  has_many :line_items, through: :orders_line_items
end
