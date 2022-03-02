
require 'pry'
require_relative 'module'
class ItemRepository
include IDManager
attr_accessor :all
  def initialize(items)
    @all = items
  end
#inspect method is required for spec harness to run
  def inspect
    "#<#{self.class} #{@all.size} rows>"
  end

  def find_all_with_description(search)
    @all.find_all{|index| index.description.upcase.include?(search.upcase)}
  end

  def find_all_by_merchant_id(merch_id)
    @all.find_all{|index| index.merchant_id.to_i == merch_id}
  end 
  
  def find_all_by_price(price)
   temp_price = (price).to_f
   new_price = BigDecimal(temp_price,4)
   @all.find_all{|index| index.unit_price == (new_price)}
  end
  def create(attributes)
    new_element = attributes
    new_element[:id] = (@all.max{|index| index.id}).id + 1
    @all << Item.new(new_element)
  end

  def find_all_by_price_in_range(range)
    new_min = BigDecimal((range.min).to_f,4)
    new_max = BigDecimal((range.max).to_f,4)
    new_range = (new_min..new_max )
   @all.find_all{|index| new_range.include?(index.unit_price)}
  end

  # def update(id, attributes)
  #   @all.each do |index|
  #     binding.pry
  #     if index.id == id
  #       index.updated_at = Time.now
  #       index.description = attributes[:description]
  #       index.name = attributes[:name]
  #       index.unit_price = attributes[:unit_price]
  #     end
  #   end
  # end


end
