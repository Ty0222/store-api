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

  describe ".within_range" do
    it "returns orders created within the given date range" do
      from_date = "2020-01-20"
      to_date = "2020-03-20"
      cart = create(:cart)
      queried_order = build(:order)
      order = build(:order)
      queried_order.line_items = [create(:line_item, cart: cart), create(:line_item, cart: cart)]
      order.line_items = [create(:line_item, cart: cart), create(:line_item, cart: cart)]
      queried_order.save
      order.save

      queried_order.update_attributes(created_at: Date.parse("2020-02-19"))

      expect(Order.within_range(from_date, to_date)).to include(queried_order)
      expect(Order.within_range(from_date, to_date)).not_to include(order)
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
