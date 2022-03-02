require_relative 'transaction'
require_relative 'module'

class TransactionRepository
  include IDManager

  attr_reader :all
  def initialize(transactions)
    @all = transactions
  end

  def find_all_by_invoice_id(id_search)
    @all.find_all{|index| index.invoice_id.to_s.include?(id_search.to_s)}
  end

  def find_all_by_credit_card_number(card_search)
    @all.find_all{|index| index.credit_card_number.to_s.include?(card_search.to_s)}
  end

  def find_all_by_result(result_search)
    @all.find_all{|index| index.result == result_search.to_sym}
  end

  def create(attributes)
    attributes[:id] = @all.length + 1
    @all << Transaction.new(attributes)
  end

  def update(id, attributes)
    selected_instance = find_by_id(id)
    attributes.each do |attr, value|
      if attr == :result
        selected_instance.result = value
        selected_instance.updated_at = Time.now
      end
    end
  end

  def inspect
  "#<#{self.class} #{@merchants.size} rows>"
  end
end
