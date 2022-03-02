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

  def update(id, attributes)
    selected_instance = find_by_id(id)
    attributes.each do |attr, value|
      if attr == :first_name
        selected_instance.description = value
        selected_instance.updated_at = Time.now
      elsif attr == :last_name
        selected_instance.unit_price = value
        selected_instance.updated_at = Time.now
      end
    end
  end
end
