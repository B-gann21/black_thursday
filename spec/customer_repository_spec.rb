require "./lib/customer_repository"
require "rspec"
RSpec.describe CustomerRepository do
  it "exists" do
    customer1 = double("customer", :id => 1, :first_name => "Joey", :last_name => "Ondricka", :created_at => "2012-03-27 14:54:09 UTC", :updated_at => "2012-03-27 14:54:09 UTC")
    customer2 = double("customer", :id => 2, :first_name => "Cecelia", :last_name => "Osinski", :created_at => "2012-03-27 14:54:10 UTC", :updated_at => "2012-03-27 14:54:10 UTC")
    customer3 = double("customer", :id => 3, :first_name => "Mariah", :last_name => "Toy", :created_at => "2012-03-27 14:54:10 UTC", :updated_at => "2012-03-27 14:54:10 UTC")
    customer_repo = CustomerRepository.new([customer1, customer2, customer3])
    expect(customer_repo).to be_a(CustomerRepository)
  end
  it "can find all first names" do
    customer1 = double("customer", :id => 1, :first_name => "Joey", :last_name => "Ondricka", :created_at => "2012-03-27 14:54:09 UTC", :updated_at => "2012-03-27 14:54:09 UTC")
    customer2 = double("customer", :id => 2, :first_name => "Cecelia", :last_name => "Osinski", :created_at => "2012-03-27 14:54:10 UTC", :updated_at => "2012-03-27 14:54:10 UTC")
    customer3 = double("customer", :id => 3, :first_name => "Joey", :last_name => "Toy", :created_at => "2012-03-27 14:54:10 UTC", :updated_at => "2012-03-27 14:54:10 UTC")
    customer_repo = CustomerRepository.new([customer1, customer2, customer3])
    expect(customer_repo.find_all_by_first_name("Joey")).to eq([customer1, customer3])
    expect(customer_repo.find_all_by_first_name("Cecelia")).to eq([customer2])
  end
  it "can find all last names" do
    customer1 = double("customer1", :id => 1, :first_name => "Bruce", :last_name => "Ondricka", :created_at => "2012-03-27 14:54:09 UTC", :updated_at => "2012-03-27 14:54:09 UTC")
    customer2 = double("customer2", :id => 2, :first_name => "Cecelia", :last_name => "Osinski", :created_at => "2012-03-27 14:54:10 UTC", :updated_at => "2012-03-27 14:54:10 UTC")
    customer3 = double("customer3", :id => 3, :first_name => "Joey", :last_name => "Osinski", :created_at => "2012-03-27 14:54:10 UTC", :updated_at => "2012-03-27 14:54:10 UTC")
    customer_repo = CustomerRepository.new([customer1, customer2, customer3])
    expect(customer_repo.find_all_by_last_name("Osinski")).to eq([customer2, customer3])
    expect(customer_repo.find_all_by_last_name("Ondricka")).to eq([customer1])
  end

  it 'can create a customer' do
    sales_engine = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :invoices     => "./data/invoices.csv",
      :invoice_items     => "./data/invoice_items.csv",
      :customers     => "./data/customers.csv",
      :transactions     => "./data/transactions.csv",
      :merchants => "./data/merchants.csv"})
    cr = sales_engine.customers
    attributes = {
      first_name: "Phillis", last_name: "Jefferson",
      created_at: Time.now, updated_at: Time.now
    }
    new_customer = cr.create(attributes)
    expect(new_customer).to be_a(Customer)
  end

  it 'can update a customer' do
    sales_engine = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :invoices     => "./data/invoices.csv",
      :invoice_items     => "./data/invoice_items.csv",
      :customers     => "./data/customers.csv",
      :transactions     => "./data/transactions.csv",
      :merchants => "./data/merchants.csv"})
    cr = sales_engine.customers
    attributes = {
      first_name: "Phillis", last_name: "Jefferson",
      created_at: Time.now, updated_at: Time.now
    }
    new_customer = cr.create(attributes)

    new_attributes = {
      first_name: "Billy", last_name: "Johnson"
    }

    cr.update(new_customer.id, new_attributes)

    expect(new_customer.first_name).to eq("Billy")
    expect(new_customer.last_name).to eq("Johnson")
  end
end
