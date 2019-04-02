require 'rails_helper'

describe 'Transaction API relationships' do
  it 'returns the associated invoice' do
    transaction = create(:transaction)

    get "/api/v1/transactions/#{transaction.id}/invoice"

    expect(response).to be_successful

    invoices = JSON.parse(response.body, symbolize_names: true)
    invoices.each do |invoice|
      expect(invoice['transaction_id']).to eq(invoice.id)
    end

    expect(invoices).to eq(transaction.invoices)
  end
end
