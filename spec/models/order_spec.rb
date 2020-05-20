require 'rails_helper'

RSpec.describe Order, type: :model do
  it { is_expected.to have_many(:orders_line_items) }
  it { is_expected.to have_many(:line_items).through(:orders_line_items) }
end
