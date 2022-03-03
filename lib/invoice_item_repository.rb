require_relative 'id_manager'
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

  def create(attributes)
    attributes[:id] = @all.length + 1
    new_invoice_item = InvoiceItem.new(attributes)
    @all << new_invoice_item
    new_invoice_item
  end

  def update(id, attributes)
    selected_instance = find_by_id(id)
    if attributes[:unit_price]
      selected_instance.unit_price = attributes[:unit_price]
      selected_instance.updated_at = Time.now
    end
    if attributes[:quantity]
      selected_instance.quantity = attributes[:quantity]
      selected_instance.updated_at = Time.now
    end

  end
  #inspect method is required for spec harness to run
  def inspect
    "#<#{self.class} #{@all.size} rows>"
  end
end
