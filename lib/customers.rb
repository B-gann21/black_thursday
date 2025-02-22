class Customer
  attr_reader :id, :created_at
  attr_accessor :first_name, :last_name, :updated_at
  def initialize(info)
    @id  = info[:id].to_i
    @first_name  = info[:first_name].to_s
    @last_name  = info[:last_name].to_s
    @created_at  = info[:created_at]
    @updated_at  = info[:updated_at]
  end
end
