class Api::V1::OrdersController < ApplicationController
  require_dependency "#{Rails.root}/app/validators/orders_controller"

  before_action :validate_params, only: :index

  def index
    @orders = Order.within_range(params[:from_date], params[:to_date])
    json_response(@orders)
  end

  private

  def validate_params
    validator = Validators::OrdersController.new(params)

    return if validator.valid?

    json_response({ errors: validator.errors }, :unprocessable_entity)
  end
end
