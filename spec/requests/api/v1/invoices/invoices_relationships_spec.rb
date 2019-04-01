require 'rails_helper'

describe 'Invoices API relationships' do
  it 'returns a collection of associated transactions' do
    invoice = create(:invoice)

    get "/api/v1/invoices/#{invoice.id}/transactions"
    expect(response).to be_successful

    transactions = JSON.parse(response.body, symbolize_names: true)

    transactions.each do |transaction|
      expect(transaction['invoice_id']).to eq(invoice.id)
    end

    expect(transactions).to eq(invoice.transactions)
  end

  it 'returns a collection of associated invoice items' do
    invoice =  create(:invoice)

    get "/api/v1/invoices/#{invoice.id}/invoice_items"

    expect(response).to be_successful

    invoice_items = JSON.parse(response.body, symbolize_names: true)

    invoice_items.each do |ii|
      expect(ii['invoice_id']).to eq(invoice.id)
    end

    expect(invoice_items).to eq(invoice.invoice_items)
  end

  it 'returns a collection of associated items' do
    invoice =  create(:invoice)

    get "/api/v1/invoices/#{invoice.id}/items"

    expect(response).to be_successful

    items = JSON.parse(response.body, symbolize_names: true)
    items.each do |item|
      expect(item['invoice_id']).to eq(invoice.id)
    end

    expect(items).to eq(invoice.items)
  end

end
