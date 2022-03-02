require 'time'
class Invoice
  attr_reader :id, :customer_id, :merchant_id, :status, :created_at, :updated_at
  attr_accessor :status, :updated_at
    def initialize(info)
      @id = info[:id].to_i
      @customer_id = info[:customer_id].to_i
      @merchant_id = info[:merchant_id].to_i
      @status = info[:status].to_sym
      @created_at = info[:created_at]
      @updated_at = info[:updated_at]
    end

end
