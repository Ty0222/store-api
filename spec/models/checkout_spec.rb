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

  describe "#total" do
    it "returns the sum of all its cart's line item totals" do
      pricing_rules = double("pricing rules")
      cart = create(:cart)
      create(:line_item, code: "CC", price: 1.50, total: 3.00, quantity: 3, cart_id: cart.id)
      create(:line_item, code: "PC", price: 2.00, total: 8.00, quantity: 5, cart_id: cart.id)

      co = Checkout.new(cart: cart, pricing_rules: pricing_rules)

      expect(co.total).to eq(11.00)
    end

    context "when there are no line items in its cart" do
      it "returns 0" do
        pricing_rules = double("pricing rules")
        cart = create(:cart)

        co = Checkout.new(cart: cart, pricing_rules: pricing_rules)

        expect(co.total).to eq(0.00)
      end
    end
  end
end
