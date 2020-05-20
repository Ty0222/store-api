require 'rails_helper'

RSpec.describe Cart, type: :model do
  it { is_expected.to have_many(:line_items).dependent(:nullify) }

  describe "#add_item" do
    it "increases its cart's line item quantity by 1" do
      pricing_rules = class_double("Discount", apply: nil)
      cart = create(:cart)
      line_item = create(:line_item, cart_id: cart.id)

      expect { cart.add_item(line_item.code, pricing_rules)
      }.to change { line_item.reload.quantity }.by(1)
    end

    it "updates its cart's line item price total" do
      pricing_rules = class_double("Discount", apply: nil)
      cart = create(:cart)
      item_price = 2.00
      line_item = create(:line_item, price: item_price, cart_id: cart.id)

      expect { cart.add_item(line_item.code, pricing_rules)
      }.to change { line_item.reload.total }.by(item_price)
    end

    context "when there is no line item for a given product in its cart" do
      it "builds the line item with the appropriate details from its corresponding product" do
        pricing_rules = class_double("Discount", apply: nil)
        item_code = "CODE"
        product = create(:product, name: "NAME", code: item_code, price: 2.00)
        cart = create(:cart)

        expect { cart.add_item(item_code, pricing_rules)
        }.to change { cart.line_items.count }.by(1)

        line_item = cart.line_items.first

        expect(line_item.code).to eq(product.code)
        expect(line_item.price).to eq(product.price)
        expect(line_item.quantity).to eq(1)
        expect(line_item.total).to eq(2.00)
      end
    end


    context "when attempting to add an item for a product that does not exist" do
      it "raises a record not found error" do
        pricing_rules = class_double("Discount", apply: nil)
        item_code = "CODE"
        cart = create(:cart)

        expect { cart.add_item(item_code, pricing_rules) }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
