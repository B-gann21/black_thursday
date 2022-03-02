require_relative 'transaction'
require_relative 'module'

class TransactionRepository
  attr_reader :all
  include IDManager

  def inspect
    "#<#{self.class} #{@all.size} rows>"
  end

  def initialize(transactions)
    @all = transactions
  end

  def find_all_by_id(id_search)
    @all.find_all{|index| index[:id].to_s.include?(id_search.to_s)}
  end

  def find_all_by_invoice_id(invoice_id_search)
    @all.find_all{|index| index.invoice_id == (invoice_id_search)}
  end

  def find_all_by_credit_card_number(card_search)
    @all.find_all{|index| index[:credit_card_number].to_s.include?(card_search.to_s)}
  end

  def find_all_by_result(result_search)
    @all.find_all{|index| index[:result] == result_search}
  end
end
