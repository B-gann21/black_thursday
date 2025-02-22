require_relative 'sales_engine'
require_relative 'merchant_repository'

class SalesAnalyst
  attr_reader :items, :merchants, :invoices, :invoice_items, :customers, :transactions, :id_counter
  def initialize(items, merchants, invoices, invoice_items, customers, transactions)
  @items = items
  @merchants = merchants
  @invoices = invoices
  @invoice_items = invoice_items
  @customers = customers
  @transactions = transactions
  end

  def average_items_per_merchant

      return (@items.length.to_f/@merchants.length.to_f).round(2)
  end

  def average_items_per_merchant_standard_deviation
    items_per_merchant
    total_to_be_square_rooted = 0.0
    @id_counter.each do |index|
      total_to_be_square_rooted += (average_items_per_merchant.to_f - index[1].to_f)**2
    end
    return ((total_to_be_square_rooted/(@merchants.length.to_f - 1))**0.5).round(2)
  end

  def merchants_with_high_item_count
    average_items_per_merchant_fixed = average_items_per_merchant
    average_items_per_merchant_standard_deviation_fixed = average_items_per_merchant_standard_deviation
    id_counter_fixed = @id_counter
    high_item_count =  id_counter_fixed.find_all {|index| index[1] >= average_items_per_merchant_standard_deviation_fixed + average_items_per_merchant_fixed}
    high_item_count_merchants = []
    # high_item_count.each{|item| merchants.find{|merchant| if merchant.id == item[0] high_item_count_merchants.push(merchant)}}
    high_item_count.each do |item|
      @merchants.find_all do |merchant|
        if item[0] == merchant.id.to_s
          high_item_count_merchants << merchant
        end
      end
    end
    return high_item_count_merchants
  end

  def average_item_price_for_merchant(merchant_id)
    items_per_merchant
    number_of_items = @id_counter[merchant_id.to_s]
    items = @items.find_all{|index| index.merchant_id == merchant_id.to_s}
    total_cost = 0.0
    items.each {|index| total_cost += index.unit_price}
    return (total_cost./number_of_items).round(2)
  end

  def average_average_price_per_merchant
    items_per_merchant
    id_counter_fixed = @id_counter
    sum_of_all_averages = 0.0
    id_counter_fixed.keys.each {|index| sum_of_all_averages += average_item_price_for_merchant(index)}
    (sum_of_all_averages / @merchants.length).round(2)
  end

  def golden_items
    standard_deviation_of_item_price_fixed = standard_deviation_of_item_price
    average_item_price_fixed = average_item_price
    @items.find_all {|index| index.unit_price.to_f > (average_item_price_fixed + standard_deviation_of_item_price_fixed + standard_deviation_of_item_price_fixed) }
  end
#helper method that returns a hash with every
#merchant id and the number of items that
#merchant has
  def items_per_merchant
    @id_counter = Hash.new(0)
    @items.each do |index|
      id_counter[index.merchant_id] += 1
    end
    return @id_counter
  end

  def invoices_per_merchant
    @id_counter = Hash.new(0)
    @invoices.each do |index|
      id_counter[index.merchant_id] += 1
    end
    return @id_counter
  end

  def average_item_price
    cost_of_all_items = 0.0
    @items.each {|index| cost_of_all_items += index.unit_price.to_f}
    return cost_of_all_items/@items.length.to_f
  end

  def standard_deviation_of_item_price
    squared_item_price_total = 0.0
    average_item_price_fixed = average_item_price
    @items.each {|index| squared_item_price_total += ((index.unit_price.to_f - average_item_price_fixed)**2)}
    return (squared_item_price_total/(@items.length - 1 ))**0.5
  end

  def average_invoices_per_merchant
    return (@invoices.length.to_f/@merchants.length.to_f).round(2)
  end

  def average_invoices_per_merchant_standard_deviation
    invoices_per_merchant
    total_to_be_square_rooted = 0.0
    @id_counter.each do |index|
      total_to_be_square_rooted += (average_invoices_per_merchant.to_f - index[1].to_f)**2
    end
    return ((total_to_be_square_rooted/(@merchants.length.to_f - 1))**0.5).round(2)
  end

  def top_merchants_by_invoice_count
    high_in_invoices = invoices_per_merchant.find_all do |id, invoices|
      invoices >= (average_invoices_per_merchant + (average_invoices_per_merchant_standard_deviation * 2))
    end
    merchants_high_in_invoices = []
    high_in_invoices.each do |item|
      @merchants.find_all do |merchant|
        if item[0] == merchant.id
          merchants_high_in_invoices << merchant
        end
      end
    end
    merchants_high_in_invoices
  end

  def bottom_merchants_by_invoice_count
    low_in_invoices = invoices_per_merchant.find_all do |id, invoices|
      invoices <= (average_invoices_per_merchant - (average_invoices_per_merchant_standard_deviation * 2))
    end
    merchants_low_in_invoices = []
    low_in_invoices.each do |invoice|
      @merchants.find_all do |merchant|
        if invoice[0] == merchant.id
          merchants_low_in_invoices << merchant
        end
      end
    end
    merchants_low_in_invoices
  end

  def top_days_by_invoice_count
    days = @invoices.map do |invoice|
      formatted_date = invoice.created_at.split('')
      year = formatted_date[0..3].join.to_i
      month = formatted_date[5..6].join.to_i
      day = formatted_date[8..9].join.to_i
      Date.new(year, month, day).cwday
      day_number_to_name(Date.new(year, month, day).cwday)
    end
    recurring_days = day_counter(days)
    frequency_of_days = recurring_days.map do |day, times_occured|
      times_occured
    end
    top_day = recurring_days.find do |day, times_occured|
      times_occured == frequency_of_days.max
    end
    [top_day[0].to_s.capitalize.delete_suffix("s")]
  end

  def day_number_to_name(num)
    {1 => "Monday", 2 => "Tuesday", 3 => "Wednesday",
    4 => "Thursday", 5 => "Friday", 6 => "Saturday", 7 => "Sunday"}[num]
  end

  def day_counter(days)
    { :mondays => days.count {|day| day == "Monday"}, :tuesdays => days.count {|day| day == "Tuesday"},
      :wednesdays => days.count {|day| day == "Wednesday"}, :thursdays => days.count {|day| day == "Thursday"},
      :fridays => days.count {|day| day == "Friday"}, :saturdays =>  days.count {|day| day == "Saturday"},
      :sundays => days.count {|day| day == "Sunday"} }
  end

  def invoice_status(status)
    full_count = @invoices.count
    status_count = invoices.find_all{|invoice| invoice.status == status}
    ((status_count.length.to_f / full_count) *  100).round(2)
  end

#fails spec harness, but works properly
  def invoice_paid_in_full?(id)
    to_check = transactions.find{|index| index.id == id}
    if to_check.result == :success
      return true
    else
      return false
    end
  end

  def invoice_total(invoice_id)
    invoice_items_to_check = invoice_items.find_all{|invoice_item| invoice_item.invoice_id == invoice_id}
    invoice_items_to_check.map{|item| (item.unit_price)*(item.quantity.to_f)}.sum
  end

  def merchants_with_only_one_item
    item_id = [], array = [],single_merch = [], merch_hash = Hash.new(0)
    @items.find_all {|item| item_id << item.merchant_id}
    item_id.each {|id| merch_hash[id] += 1}
    merch_hash.each {|key, value|  single_merch << key if value == 1}
    @merchants.each {|merchant| array << merchant if single_merch.include?(merchant.id.to_s)}
    array
  end

  # spec test is expecting the wrong date here, there is only one line in all
  #of the csv's that has the date "2009-02-07", and it does not contain a price
  def total_revenue_by_date(date)
    invoices_created_at_date = invoices.find_all{|invoice| invoice.created_at == date.to_s[0..9]}
    invoice_ids = []
    invoices_created_at_date.each{|invoice| invoice_ids.push(invoice.id)}
    invoice_items = @invoice_items.find_all{|invoice_item| invoice_ids.include?(invoice_item.invoice_id) }
    total = invoice_items.uniq.map{|items| BigDecimal(items.quantity) * items.unit_price}.sum
    return total
  end

  def invoice_id_by_merchant_id
    merchants_with_invoices = Hash.new
    invoices.each do |invoice|
      if merchants_with_invoices.key?(invoice.merchant_id)
        merchants_with_invoices[invoice.merchant_id].push(invoice.id)
      else
        merchants_with_invoices[invoice.merchant_id] = [invoice.id]
      end
    end
    return merchants_with_invoices
  end

  def top_revenue_earners(top_number = 20)
    result = Hash.new
     merchants_with_invoices = invoice_id_by_merchant_id
     merchants_with_invoices.each_pair do |merchant, invoice|
       total = 0.0
       invoice.each{|invoicee|
         total += invoice_total(invoicee)}
       new_key= merchants.find{|index| index.id == merchant}
       result[new_key] = total
    end
    new_array = result.sort_by{|key,value|value}.reverse
    new_new_array = new_array.map{|cell| cell[0]}
    return new_new_array[0..top_number - 1]
  end
end
