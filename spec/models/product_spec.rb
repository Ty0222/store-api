require 'rails_helper'

RSpec.describe Product, type: :model do
  it { is_expected.to validate_presence_of(:code) }
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:price) }
  it { is_expected.to validate_uniqueness_of(:code) }
  it { is_expected.to validate_uniqueness_of(:name) }

  describe "#price" do
    it "returns a decimal formatted in float notation" do
      price = 2.00
      product = create(:product, :coca_cola, price: price)

      expect(product.price).to eq(price)
    end
  end
end
