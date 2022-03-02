require 'rspec'
require './lib/invoice_item_repository'

describe InvoiceItemRepository do
  before (:each) do
    @invoice_item1 = double('item1')
    @invoice_item2 = double('item2')
    @invoice_item3 = double('item3')

    allow(@invoice_item1).to receive(:id){6}
    allow(@invoice_item1).to receive(:item_id){7}
    allow(@invoice_item1).to receive(:invoice_id){8}
    allow(@invoice_item1).to receive(:quantity){1}
    allow(@invoice_item1).to receive(:unit_price){BigDecimal(10.99, 4)}
    allow(@invoice_item1).to receive(:created_at){Time.now}
    allow(@invoice_item1).to receive(:updated_at){Time.now}

    allow(@invoice_item2).to receive(:id){9}
    allow(@invoice_item2).to receive(:item_id){10}
    allow(@invoice_item2).to receive(:invoice_id){11}
    allow(@invoice_item2).to receive(:quantity){1}
    allow(@invoice_item2).to receive(:unit_price){BigDecimal(20.99, 4)}
    allow(@invoice_item2).to receive(:created_at){Time.now}
    allow(@invoice_item2).to receive(:updated_at){Time.now}

    allow(@invoice_item3).to receive(:id){12}
    allow(@invoice_item3).to receive(:item_id){13}
    allow(@invoice_item3).to receive(:invoice_id){14}
    allow(@invoice_item3).to receive(:quantity){1}
    allow(@invoice_item3).to receive(:unit_price){BigDecimal(10.99, 4)}
    allow(@invoice_item3).to receive(:created_at){Time.now}
    allow(@invoice_item3).to receive(:updated_at){Time.now}
  end
  it 'exists' do
    iir = InvoiceItemRepository.new([@invoice_item1, @invoice_item2, @invoice_item3])
    expect(iir).to be_a(InvoiceItemRepository)
  end
  it 'can find_all_by_invoice id' do
    iir = InvoiceItemRepository.new([@invoice_item1, @invoice_item2, @invoice_item3])
    found = iir.find_all_by_invoice_id(11)
    expect(found).to eq([@invoice_item2])
  end

  it 'can create a new invoice item' do
    sales_engine = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :invoices     => "./data/invoices.csv",
      :invoice_items     => "./data/invoice_items.csv",
      :customers     => "./data/customers.csv",
      :transactions     => "./data/transactions.csv",
      :merchants => "./data/merchants.csv"})
    iir = sales_engine.invoice_items
    attributes = {
      item_id: 876587658765, invoice_id: 98459834765,
      quantity: 600, unit_price: 1099,
      created_at: Time.now, updated_at: Time.now
    }
    new_invoice_item = iir.create(attributes)

    expect(new_invoice_item).to be_a(InvoiceItem)
  end

  it 'can update an invoice item' do
    sales_engine = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :invoices     => "./data/invoices.csv",
      :invoice_items     => "./data/invoice_items.csv",
      :customers     => "./data/customers.csv",
      :transactions     => "./data/transactions.csv",
      :merchants => "./data/merchants.csv"})
    iir = sales_engine.invoice_items
    attributes = {
      item_id: 876587658765, invoice_id: 98459834765,
      quantity: 600, unit_price: 1099,
      created_at: Time.now, updated_at: Time.now
    }
    new_invoice_item = iir.create(attributes)


    iir.update(new_invoice_item.id, {unit_price: 500, quantity: 200})

    expect(new_invoice_item.unit_price).to eq(500)
    expect(new_invoice_item.quantity).to eq(200)
  end
end
