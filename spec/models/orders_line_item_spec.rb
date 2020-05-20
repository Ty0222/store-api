require 'rails_helper'

RSpec.describe OrdersLineItem, type: :model do
  it { is_expected.to belong_to(:order) }
  it { is_expected.to belong_to(:line_item) }
end
