require './lib/transaction_repo.rb'
require './lib/transaction.rb'

RSpec.describe TransactionRepository do
  before (:each) do
    @transaction1 = Transaction.new ({
      id: 1,
      invoice_id: 123648,
      credit_card_number: 1432,
      result: "success"
      })
    @transaction2 = Transaction.new  ({
      id: 2,
      invoice_id: 182798,
      credit_card_number: 8256,
      result: "failed"
      })
    @transaction3 = Transaction.new({
      id: 3,
      invoice_id: 123674,
      credit_card_number: 8275,
      result: "success"
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
    expect(@tr.find_all_by_invoice_id(12)).to eq([@transaction1,@transaction3])
  end

  it 'can find all transactions by credit_card_number' do
    expect(@tr.find_all_by_credit_card_number(5)).to eq([@transaction2, @transaction3])
  end

  it 'can find all transactions by result' do
    expect(@tr.find_all_by_result("success")).to eq([@transaction1, @transaction3])
  end
end
