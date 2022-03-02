require 'bigdecimal'
class InvoiceItem
  attr_accessor :unit_price, :quantity, :updated_at
  attr_reader :id, :item_id, :invoice_id, :created_at
  def initialize(info)
    @id = info[:id]
    @item_id = info[:item_id]
    @invoice_id = info[:invoice_id]
    @quantity = info[:quantity]
    @unit_price = info[:unit_price]
    @created_at = info[:created_at]
    @updated_at = info[:updated_at]
  end

  def unit_price_to_dollars
    @unit_price.to_f
  end
end
