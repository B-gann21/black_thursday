require_relative 'transaction'
require_relative 'module'

class TransactionRepository
  include IDManager

  attr_reader :all
  def initialize(transactions)
    @all = transactions
  end

  def find_all_by_id(id_search)
    @all.find_all{|index| index[:id].to_s.include?(id_search.to_s)}
  end

  def find_all_by_credit_card_number(card_search)
    @all.find_all{|index| index[:credit_card_number].to_s.include?(card_search.to_s)}
  end

  def find_all_by_result(result_search)
    @all.find_all{|index| index[:result] == result_search}
  end

  def create(attributes)
    attributes[:id] = (@all.max{|index| index.id}).id + 1
    new_transaction = Transaction.new(attributes)
    @all << new_transaction
    new_transaction
  end

  def update(id, attributes)
    selected_instance = find_by_id(id)
    if attributes[:credit_card_number]
      selected_instance.credit_card_number = attributes[:credit_card_number]
      selected_instance.updated_at = Time.now
    end
    if attributes[:credit_card_expiration_date]
      selected_instance.credit_card_expiration_date = attributes[:credit_card_expiration_date]
      selected_instance.updated_at = Time.now
    end
    if attributes[:result]
      selected_instance.result = attributes[:result]
      selected_instance.updated_at = Time.now
    end
  end
end
