
require 'pry'
require_relative 'id_manager'
require_relative 'item'
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
   @all.find_all{|index| index.unit_price == BigDecimal(temp_price, 4)}
  end
  def create(attributes)
    attributes[:id] = (@all.max{|index| index.id}).id + 1
    new_item = Item.new(attributes)
    @all << new_item
    new_item
  end

  def find_all_by_price_in_range(range)
    new_min = BigDecimal((range.min).to_f,4)
    new_max = BigDecimal((range.max).to_f,4)
    new_range = (new_min..new_max)
   @all.find_all{|index| new_range.include?(index.unit_price)}
  end
  def update(id, attributes)
    selected_instance = find_by_id(id)
    attributes.each do |attr, value|
      if attr == :description
        selected_instance.description = value
        selected_instance.updated_at = Time.now
      elsif attr == :unit_price
        selected_instance.unit_price = value
        selected_instance.updated_at = Time.now
      elsif attr == :name
        selected_instance.name = value
        selected_instance.updated_at = Time.now
      end
    end
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
