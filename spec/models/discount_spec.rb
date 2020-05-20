require 'rails_helper'

RSpec.describe Discount, type: :model do
  describe ".apply" do
    context "when the line item code represents a Pepsi-Cola and there is a quantity of at least 3" do
      it "discounts the price of each item by 20 percent" do
        line_item = build(:line_item, code: "PC", quantity: 4, price: 2.00, total: 8.00)

        expect(Discount.apply(line_item)).to eq(6.40)
      end
    end

    context "when the line item code represents a Coca-Cola and there is a quantity of at least 2" do
      it "does not add the price for the second item to the total" do
        line_item = build(:line_item, code: "CC", quantity: 3, price: 1.50, total: 4.50)

        expect(Discount.apply(line_item)).to eq(3.00)
      end
    end

    context "when there are no discounts available for the given line item" do
      it "returns nil" do
        line_item = build(:line_item, code: "WA", quantity: 1, price: 0.85, total: 0.85)

        expect(Discount.apply(line_item)).to eq(nil)
      end
    end
  end
end
