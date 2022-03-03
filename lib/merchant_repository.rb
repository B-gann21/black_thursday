require_relative "id_manager"
require_relative 'merchant'
class MerchantRepository
  include IDManager

attr_reader :all
  def initialize(merchants)
    @all = merchants
  end
  def find_all_by_name(search)
    @all.find_all{|index| index.name.upcase.include?(search.upcase)}
  end
  def create(attributes)
    attributes[:id] = (@all.max{|index| index.id}).id + 1
    new_merchant = Merchant.new(attributes)
    @all << new_merchant
    new_merchant
  end
  def update(id, attributes)
    selected_instance = find_by_id(id)
    selected_instance.name = attributes[:name] if attributes[:name]
  end
#inspect method is required for spec harness to run
  def inspect
    "#<#{self.class} #{@all.size} rows>"
  end

end
