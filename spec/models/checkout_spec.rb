require 'rails_helper'

RSpec.describe Checkout, type: :model do
  describe "#cart" do
    it "returns the cart instance passed in during initialization" do
      pricing_rules = double("pricing rules")
      cart = instance_double("Cart")
      co = Checkout.new(cart: cart, pricing_rules: pricing_rules)

      expect(co.cart).to eq(cart)
    end
  end

  describe "#add_item" do
    it "delegates to its cart #add_item method" do
      item = double("item")
      pricing_rules = double("pricing rules")
      cart = instance_spy("Cart")
      co = Checkout.new(cart: cart, pricing_rules: pricing_rules)

      co.add_item(item)

      expect(cart).to have_received(:add_item).with(item, pricing_rules)
    end
  end
end
