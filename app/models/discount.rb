class Discount
  def self.apply(line_item)
    discounts(line_item)
  end

  def self.discounts(item)
    { "PC" => pepsi_cola(item), "CC" => coca_cola(item) }[item.code]
  end

  def self.pepsi_cola(item)
    (item.price * item.quantity) * 0.80 if item.quantity >= 3
  end

  def self.coca_cola(item)
    (item.price * item.quantity) - item.price if item.quantity >= 2
  end

  private_class_method :discounts, :pepsi_cola, :coca_cola
end
