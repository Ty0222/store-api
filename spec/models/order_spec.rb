require 'rails_helper'

RSpec.describe Order, type: :model do
  it { is_expected.to have_many(:orders_line_items) }
  it { is_expected.to have_many(:line_items).through(:orders_line_items) }

  describe "callbacks" do
    context "before creating a new order" do
      it "fills in its total column with the sum of its line items' total" do
        cart = create(:cart)
        line_items = [create(:line_item, total: 2.00, cart: cart), create(:line_item, total: 3.00, cart: cart)]
        order = build(:order)
        order.line_items = line_items
        
        expect(order.total).to eq(0.00)

        order.save

        expect(order.total).to eq(5.00)
      end
    end
  end

  describe "#total" do
    it "returns a formatted decimal" do
      order_total = 2.00
      order = build(:order, total: order_total)

      expect(order.total).to eq(order_total)
    end
  end
end
