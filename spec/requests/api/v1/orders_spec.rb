require 'rails_helper'

RSpec.describe 'Orders API', type: :request do
  describe 'GET /api/v1/orders' do
    context "when passing in a date range" do
      it "returns orders created within the range along with its assocated line items" do
        cart = create(:cart)
        queried_order = build(:order)
        order = build(:order)
        queried_order.line_items = [create(:line_item, cart: cart), create(:line_item, cart: cart)]
        order.line_items = [create(:line_item, cart: cart), create(:line_item, cart: cart)]
        queried_order.save
        order.save

        queried_order.update_attributes(created_at: Date.parse("2020-02-19"))

        get '/api/v1/orders', params: { from_date: "2020-01-20", to_date: "2020-03-20" }

        expect(json.size).to eq(1)
        expect(json.first["id"]).to eq(queried_order.id)
        expect(json.first["total"]).to eq(4.00)
        expect(json.last["id"]).not_to eq(order.id)
      end

      it 'returns status code 200' do
        get '/api/v1/orders', params: { from_date: "2020-01-20", to_date: "2020-03-20" }

        expect(response).to have_http_status(200)
      end
    end

    context "when no orders exists within the given date range" do
      it "returns an empty json response" do
        get '/api/v1/orders', params: { from_date: "2020-01-20", to_date: "2020-03-20" }

        expect(json).to be_empty
      end
    end

    context "when not passing in a date param" do
      it "returns an error response" do
        get '/api/v1/orders', params: { from_date: "2020-01-21" }

        expect(json["errors"]["to_date"]).to include("can't be blank")
      end
    end

    context "when passing in an empty string for a date" do
      it "returns an error response" do
        get '/api/v1/orders', params: { from_date: "2020-01-21", to_date: "" }

        expect(json["errors"]["to_date"]).to include("can't be blank")
      end
    end

    context "when passing in a param that isn't whitelisted" do
      it "returns an error response" do
        get '/api/v1/orders', params: { from_date: "2020-01-21", end_date: "2020-01-21" }

        expect(json["errors"]["unknown_parameters"]).to include("end_date")
      end
    end

    context "when passing in an invalid date format" do
      it "returns an error response" do
        get '/api/v1/orders', params: { from_date: "2020-21-21", to_date: "2020-01-20" }

        expect(json["errors"]["from_date"]).to include("must use the format yyyy-mm-dd")
      end
    end

    context "when passing in an invalid date range" do
      it "returns an error response" do
        get '/api/v1/orders', params: { from_date: "2020-01-21", to_date: "2020-01-20" }

        expect(json["errors"]["from_date"]).to include("must start before the to date")
        expect(json["errors"]["to_date"]).to include("must end after the from date")
      end
    end
  end
end
