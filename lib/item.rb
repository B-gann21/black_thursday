require 'bigdecimal'

class Item
  attr_accessor :description, :unit_price, :name, :updated_at
  attr_reader :id,
              :created_at,
              :merchant_id
  def initialize(details)
    @id = details[:id].to_i
    @name = details[:name]
    @description = details[:description]
    @unit_price = BigDecimal(details[:unit_price],4)/100
    @created_at = details[:created_at]
    @updated_at = details[:updated_at]
    @merchant_id = details[:merchant_id]
  end

  def unit_price_to_dollars
    ((@unit_price).round(2).to_f)
  end
end
