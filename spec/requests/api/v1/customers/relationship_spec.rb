require 'rails_helper'

describe 'Customer API relationships' do
  it 'returns a collection of associated invoices' do
    customer = create(:customer)

    get "/api/v1/customers/#{customer.id}/invoices"

    expect(response).to be_successful

    invoices = JSON.parse(response.body, symbolize_names: true)
    invoices.each do |invoice|
      expect(invoice[:customer_id]).to eq(customer.invoices)
    end

    expect(customer).to eq(invoices.customer)
  end
end
