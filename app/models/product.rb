class Product < ApplicationRecord
  validates :code, :name, :price, presence: true
  validates :code, :name, uniqueness: true

  def price
    read_attribute(:price).to_f if read_attribute(:price)
  end
end
