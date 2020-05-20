require 'rails_helper'

RSpec.describe OrdersLineItem, type: :model do
  it { is_expected.to belong_to(:order) }
  it { is_expected.to belong_to(:line_item) }
  it { is_expected.to validate_presence_of(:order_id) }
  it { is_expected.to validate_presence_of(:line_item_id) }
end
