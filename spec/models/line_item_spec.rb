require 'rails_helper'

RSpec.describe LineItem, type: :model do
  it { is_expected.to belong_to(:cart) }
  it { is_expected.to validate_presence_of(:code) }
  it { is_expected.to validate_presence_of(:quantity) }
  it { is_expected.to validate_presence_of(:price) }
  it { is_expected.to validate_presence_of(:total) }
  it { is_expected.to validate_presence_of(:cart_id) }
  it { is_expected.to validate_uniqueness_of(:code) }

  describe "#update_total" do
    context "when there are discounts available for the given line item" do
      it "applies the discount to the line item total" do
        pricing_rules = class_spy("Discount")
        line_item = build(:line_item)

        line_item.update_total(pricing_rules)

        expect(pricing_rules).to have_received(:apply)
      end  
    end

    context "when there are no discounts available for the given line item" do
      it "updates the total price by adding the line item price to it" do
        pricing_rules = class_double("Discount", apply: nil)
        cart = build_stubbed(:cart)
        line_item_price = 2.00
        line_item = build(:line_item, price: line_item_price)

        expect { line_item.update_total(pricing_rules)
        }.to change { line_item.total }.by(line_item_price)
      end
    end
  end

  describe "#price" do
    it "returns a formatted decimal" do
      line_item_price = 2.00
      line_item = build(:line_item, price: line_item_price)

      expect(line_item.price).to eq(line_item_price)
    end
  end

  describe "#total" do
    it "returns a formatted decimal" do
      line_item_total = 2.00
      line_item = build(:line_item, total: line_item_total)

      expect(line_item.total).to eq(line_item_total)
    end
  end
end
