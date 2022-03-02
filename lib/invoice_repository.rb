require_relative 'module'
class InvoiceRepository
  include IDManager
  attr_accessor :status, :updated_at
  attr_reader :all
  def initialize(info)
    @all = info
  end

  def find_all_by_status(search)
    @all.find_all{|index| index.status == search.to_sym}
  end

  def find_all_by_merchant_id(search)
    @all.find_all{|index| index.merchant_id == search}
  end

  def find_all_by_customer_id(search)
    @all.find_all{|index| index.customer_id == search}
  end

  def create(attributes)
    attributes[:id] = @all.length + 1
    new_item = Invoice.new(attributes)
    @all << new_item
  end

  def inspect
    "#<#{self.class} #{@all.size} rows>"
  end

  def update(id, attributes)
    selected_instance = find_by_id(id)
    attributes.each do |attr, value|
      if attr == :status
        selected_instance.status = value
        selected_instance.updated_at = Time.now
      end
    end
  end

end
