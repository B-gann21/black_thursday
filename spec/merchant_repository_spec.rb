require './lib/merchant_repository'

RSpec.describe MerchantRepository do

  before (:each) do
    @merchant1 = double('merchant')
    @merchant2 = double('merchant')
    @merchant3 = double('merchant')
    allow(@merchant1).to receive(:name){"NicKnacItems"}
    allow(@merchant1).to receive(:id){1}
    allow(@merchant2).to receive(:name){"NicksGoods"}
    allow(@merchant2).to receive(:id){2}
    allow(@merchant3).to receive(:name){"twosquaredblocks"}
    allow(@merchant3).to receive(:id){3}
    @mr = MerchantRepository.new([@merchant1, @merchant2, @merchant3])
  end

  it 'can list all merchants' do
    expect(@mr.all).to eq([@merchant1, @merchant2, @merchant3])
  end


  it 'can find all merchants that include fragment' do
    expect(@mr.find_all_by_name("nick")).to eq([@merchant1,@merchant2])
  end

  it '#create can create a merchant' do
    sales_engine = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :invoices     => "./data/invoices.csv",
      :invoice_items     => "./data/invoice_items.csv",
      :customers     => "./data/customers.csv",
      :transactions     => "./data/transactions.csv",
      :merchants => "./data/merchants.csv"})
    mr = sales_engine.merchants
    merchant4 = mr.create({id: 600, name: "BillyJoes"})
    expect(merchant4).to be_a(Merchant)
  end

  it 'can update a merchant' do
    sales_engine = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :invoices     => "./data/invoices.csv",
      :invoice_items     => "./data/invoice_items.csv",
      :customers     => "./data/customers.csv",
      :transactions     => "./data/transactions.csv",
      :merchants => "./data/merchants.csv"})
    mr = sales_engine.merchants
    attributes = {
        name: "BillyBob"
      }
      merchant4 = mr.create(attributes)
      expect(merchant4.name).to eq("BillyBob")

      mr.update(merchant4.id, {name: "BillyJoe"})

      expect(merchant4.name).to eq("BillyJoe")
  end
end
