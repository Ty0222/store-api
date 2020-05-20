class Order < ApplicationRecord
  has_many :orders_line_items
  has_many :line_items, through: :orders_line_items

  before_create :add_total

  scope :within_range, -> (from, to) { where(created_at: from..to) }

  def total
    read_attribute(:total).to_f if read_attribute(:total)
  end

  private

  def add_total
    self.total = line_items.map(&:total).sum.to_f
  end
end
