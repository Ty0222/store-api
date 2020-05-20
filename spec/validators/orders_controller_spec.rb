require 'rails_helper'

RSpec.describe Validators::OrdersController, type: :validator do
  it { is_expected.to validate_presence_of(:from_date) }
  it { is_expected.to validate_presence_of(:to_date) }
  it { is_expected.to permit(:from_date, :to_date).for(api_v1_orders_path, verb: :get) }

  it "validates the format of the from and to dates" do
    valid_date_range1 = { from_date: "2020-02-22", to_date: "2020-02-23" }
    invalid_date_range1 = { from_date: "20-22-2020", to_date: "20-22-2020" }
    invalid_date_range2 = { from_date: "20-2000-02", to_date: "20-2000-02" }
    invalid_date_range3 = { from_date: "dd-22-2020", to_date: "dd-22-2020" }
    invalid_date_range4 = { from_date: "2020-2-02", to_date: "2020-2-02" }
    invalid_date_range5 = { from_date: "2020-22-02", to_date: "2020-23-02" }
    invalid_date_range6 = { from_date: "2020-02-22", to_date: "2020-02--23" }

    valid_validator1 = described_class.new(valid_date_range1)
    invalid_validator1 = described_class.new(invalid_date_range1)
    invalid_validator2 = described_class.new(invalid_date_range2)
    invalid_validator3 = described_class.new(invalid_date_range3)
    invalid_validator4 = described_class.new(invalid_date_range4)
    invalid_validator5 = described_class.new(invalid_date_range5)
    invalid_validator6 = described_class.new(invalid_date_range6)

    expect(valid_validator1).to be_valid
    expect(invalid_validator1).not_to be_valid
    expect(invalid_validator2).not_to be_valid
    expect(invalid_validator3).not_to be_valid
    expect(invalid_validator4).not_to be_valid
    expect(invalid_validator5).not_to be_valid
    expect(invalid_validator6).not_to be_valid
  end

  it "validates that the from and to date don't surpass each other" do
    valid_date_range1 = { from_date: "2020-02-22", to_date: "2020-02-23" }
    invalid_date_range1 = { from_date: "2020-02-22", to_date: "2020-02-22" }
    invalid_date_range2 = { from_date: "2020-02-23", to_date: "2020-02-22" }
    valid_validator1 = described_class.new(valid_date_range1)
    invalid_validator1 = described_class.new(invalid_date_range1)
    invalid_validator2 = described_class.new(invalid_date_range2)

    expect(valid_validator1).to be_valid
    expect(invalid_validator1).not_to be_valid
    expect(invalid_validator2).not_to be_valid
  end
end
