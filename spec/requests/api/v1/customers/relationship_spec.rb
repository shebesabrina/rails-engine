require 'rails_helper'

describe 'Customer API relationships' do
  it 'returns a collection of associated invoices' do
    customer = create(:customer)

    get "/api/v1/customers/#{customer.id}/invoices"

    expect(response).to be_successful

    invoices = JSON.parse(response.body)
    invoices.each do |invoice|
      expect(invoice['customer_id']).to eq(customer.id)
    end
    expect(invoices).to eq(customer.invoices)
  end
end
