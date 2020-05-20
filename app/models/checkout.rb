class Checkout

  attr_reader :cart

  def initialize(cart:, pricing_rules: Discount)
    @cart = cart
    @pricing_rules = pricing_rules
  end

  def add_item(item)
    cart.add_item(item, pricing_rules)
  end

  def total
    cart.line_items.sum(:total).to_f
  end

  private

  attr_reader :pricing_rules
end
