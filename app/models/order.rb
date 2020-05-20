class Order < ApplicationRecord
  has_many :orders_line_items
  has_many :line_items, through: :orders_line_items

  before_create :add_total

  def total
    read_attribute(:total).to_f if read_attribute(:total)
  end

  private

  def add_total
    self.total = line_items.map(&:total).sum.to_f
  end
end
