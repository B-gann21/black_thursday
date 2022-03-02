require_relative "module"
class CustomerRepository
  include IDManager

  def initialize(info)
    @all = info
  end

  def find_all_by_first_name(first_name)
    @all.find_all{|index| index.first_name == first_name}
  end

  def find_all_by_last_name(last_name)
    @all.find_all{|index| index.last_name == last_name}
  end

  def inspect
    "#<#{self.class} #{@all.size} rows>"
  end

  def create(attributes)
    attributes[:id] = (@all.max{|index| index.id}).id + 1
    new_customer = Customer.new(attributes)
    @all << new_customer
    new_customer
  end

  def update(id, attributes)
    selected_instance = find_by_id(id)
    if attributes[:first_name]
      selected_instance.first_name = attributes[:first_name]
      selected_instance.updated_at = Time.now
    end
    if attributes[:last_name]
      selected_instance.last_name = attributes[:last_name]
      selected_instance.updated_at = Time.now
    end
  end

end
