module IDManager
  def find_by_id(id)
    @all.find{|index| index.id.to_i == id}
  end

  def find_by_name(search)
    @all.find{|index| index.name.upcase == search.upcase}
  end

  def delete(id)
    @all.delete(find_by_id(id))
  end
end
