module Validators
  class OrdersController
    include ActiveModel::Validations

    attr_accessor :from_date, :to_date

    validates :from_date, :to_date, presence: true
    validate :params_are_permitted
    validate :valid_date_format
    validate :valid_date_range

    def initialize(params={})
      @from_date  = params[:from_date]
      @to_date = params[:to_date]
      @params = convert_to_parameter_object(params)
    end

    private

    attr_reader :params

    # Validation methods

    def params_are_permitted
      ActionController::Parameters.action_on_unpermitted_parameters = :raise

      params.permit(:from_date, :to_date)
      rescue ActionController::UnpermittedParameters => e
        errors.add(:unknown_parameters, *e.params)
    end

    def valid_date_format
      return unless from_date.present? && to_date.present?
      dates = { from_date: from_date, to_date: to_date }

      dates.each do |attribute, date|
        next if date_correctly_formated(date)
        errors.add(attribute, "must use the format yyyy-mm-dd")
      end
    end

    def valid_date_range
      if from_date.present? && to_date.present? && from_date >= to_date
        errors.add(:from_date, "must start before the to date")
        errors.add(:to_date, "must end after the from date")
      end
    end

    # Helper methods

    def date_correctly_formated(date)
      date_format = /\d\d\d\d\-\d\d\-\d\d/
      year, month, day = date.split("-")

      date =~ date_format && Date.valid_date?(year.to_i, month.to_i, day.to_i)
    end

    def convert_to_parameter_object(params)
      return params if params.kind_of? ActionController::Parameters
      ActionController::Parameters.new(params)
    end
  end
end
