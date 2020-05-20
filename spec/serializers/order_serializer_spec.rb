require 'rails_helper'

RSpec.describe OrderSerializer, type: :serializer do
  describe "attributes" do
    it "includes only whitelisted attributes" do
      whitelisted_attributes = ["id", "total", "created_at", "updated_at", "line_items"]
      cart = create(:cart)
      order = build(:order)
      order.line_items = [create(:line_item, cart: cart), create(:line_item, cart: cart)]
      order.save

      serialized = serialize(order)
      expect(serialized.keys).to eq whitelisted_attributes
      expect(serialized["id"]).to eq order.id
      expect(serialized["total"]).to eq 4.00
      expect(serialized["line_items"].first["quantity"]).to eq(1)
    end
  end
end
