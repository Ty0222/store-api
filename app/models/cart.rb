class Cart < ApplicationRecord
  has_many :line_items, dependent: :nullify

  def add_item(code, pricing_rules)
    line_item = line_item_from_code(code)
    line_item.quantity += 1
    line_item.update_total(pricing_rules)
    line_item.save
  end

  private

  def line_item_from_code(code)
     line_items.find_by(code: code) || build_line_item(code)
  end

  def build_line_item(code)
    product = Product.find_by!(code: code)
    line_items.new(code: product.code, price: product.price)
  end
end
