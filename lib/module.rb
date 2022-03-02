module IDManager
  def find_by_id(id)
    @all.find{|index| index.id.to_i == id}
  end

  def find_by_name(search)
    @all.find{|index| index.name.upcase == search.upcase}
  end

  # def create(attributes)
  #   attributes[:id] = @all.length +1
  #   if self.class == MerchantRepository
  #     @all << Merchant.new(attributes)
  #   elsif self.class == ItemRepository
  #     @all << Item.new(attributes)
  #   elsif self.class == CustomerRepository
  #     @all << Customer.new(attributes)
  #   elsif self.class == InvoiceRepository
  #     @all << Invoice.new(attributes)
  #   elsif self.class == InvoiceItemRepository
  #     @all << InvoiceItem.new(attributes)
  #   elsif self.class == TransactionRepository
  #     @all << Transaction.new(attributes)
  #   end
  #end

  def update(id, attributes)
    seleted_instance = find_by_id(id)
    if attributes.key?(:name)
      seleted_instance.name = attributes[:name]
      seleted_instance.updated_at = (Time.now).to_s
    elsif attributes.key?(:status)
      seleted_instance.status = attributes[:status]
      seleted_instance.updated_at = (Time.now).to_s
    end
  end




  # def update(id, attributes)
  #   updated_hash = attributes
  #   find_by_id(id).merge(updated_hash)
  # end

  def delete(id)
    @all.delete(find_by_id(id))
  end
end
