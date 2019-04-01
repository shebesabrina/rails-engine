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

end
