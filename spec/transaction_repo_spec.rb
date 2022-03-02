require './lib/transaction_repo.rb'

RSpec.describe TransactionRepository do
  before (:each) do

    @transaction1 = Transaction.new({
      id: 1,
      credit_card_number: 1432,
      result: "success",
      invoice_id: 23412,
      credit_card_expiration_date: "1212",
      created_at: Time.now,
      updated_at: Time.now
      })
    @transaction2 =  Transaction.new({
      id: 6,
      credit_card_number: 1514,
      result: "failed",
      invoice_id: 23543562,
      credit_card_expiration_date: "1111",
      created_at: Time.now,
      updated_at: Time.now
      })
    @transaction3 =  Transaction.new({
      id: 7,
      credit_card_number: 1514,
      result: "failed",
      invoice_id: 23543565432,
      credit_card_expiration_date: "2222",
      created_at: Time.now,
      updated_at: Time.now
      })
  
    @tr = TransactionRepository.new([@transaction1, @transaction2, @transaction3])
  end

  it 'exists' do
    expect(@tr).to be_a(TransactionRepository)
  end

  it 'can show all transactions' do
    expect(@tr.all).to eq([@transaction1, @transaction2, @transaction3])
  end

  it 'can find all by a specific transactions id' do
    expect(@tr.find_all_by_id(6)).to eq([@transaction2])
  end

  it 'can find all transactions by credit_card_number' do
    expect(@tr.find_all_by_credit_card_number("1514")).to eq([@transaction2, @transaction3])
  end

  it 'can find all transactions by result' do
    expect(@tr.find_all_by_result("success")).to eq([@transaction1, @transaction3])
  end

  it 'can create a new transaction' do
    sales_engine = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :invoices     => "./data/invoices.csv",
      :invoice_items     => "./data/invoice_items.csv",
      :customers     => "./data/customers.csv",
      :transactions     => "./data/transactions.csv",
      :merchants => "./data/merchants.csv"})
    tr = sales_engine.transactions
    attributes = {
      invoice_id: 93487592857, credit_card_number: 2387465982374659,
      credit_card_expiration_date: "0922", result: "failed",
      created_at: Time.now, updated_at: Time.now
    }

    new_transaction = tr.create(attributes)

    expect(new_transaction).to be_a(Transaction)
  end

  it 'can update a transaction' do
    sales_engine = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :invoices     => "./data/invoices.csv",
      :invoice_items     => "./data/invoice_items.csv",
      :customers     => "./data/customers.csv",
      :transactions     => "./data/transactions.csv",
      :merchants => "./data/merchants.csv"})
    tr = sales_engine.transactions
    attributes = {
      invoice_id: 93487592857, credit_card_number: 2387465982374659,
      credit_card_expiration_date: "0922", result: "failed",
      created_at: Time.now, updated_at: Time.now
    }

    new_transaction = tr.create(attributes)

    new_attributes = {
      credit_card_number: 757575757575, credit_card_expiration_date: "0912",
      result: "success"
    }

    tr.update(new_transaction.id, new_attributes)

    expect(new_transaction.credit_card_number).to eq(757575757575)
    expect(new_transaction.credit_card_expiration_date).to eq("0912")
    expect(new_transaction.result).to eq("success")
  end
end
