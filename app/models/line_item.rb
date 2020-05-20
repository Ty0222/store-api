class LineItem < ApplicationRecord
  belongs_to :cart

  validates :code, :quantity, :price, :total, :cart_id, presence: true
  validates :code, uniqueness: true

  def update_total(pricing_rules)
    self.total = pricing_rules.apply(self) || add_item_price_to_total
  end

  def price
    read_attribute(:price).to_f if read_attribute(:price)
  end

  def total
    read_attribute(:total).to_f if read_attribute(:total)
  end

  private

  def add_item_price_to_total
    total + price
  end
end
