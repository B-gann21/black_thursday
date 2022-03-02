require_relative 'module'
class InvoiceItemRepository
  include IDManager
  attr_reader :all
  def initialize(all)
    @all = all
  end

  def find_all_by_invoice_id(invoice_id)
    @all.find_all { |item| item.invoice_id == invoice_id}
  end

  def find_all_by_item_id(item_id)
    @all.find_all { |item| item.item_id == item_id}
  end
  #inspect method is required for spec harness to run
  def inspect
    "#<#{self.class} #{@all.size} rows>"
  end
end
