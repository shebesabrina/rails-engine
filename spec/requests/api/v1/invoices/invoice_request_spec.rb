require 'rails_helper'

describe 'Invoices API' do
  it 'sends all invoices' do
    create_list(:invoice, 4)

    get '/api/v1/invoices'

    expect(response).to be_successful

    invoices = JSON.parse(response.body, symbolize_names: true)

    invoices.each do |invoice|
      expect(invoice).to have_key(:id)
      expect(invoice).to have_key(:customer_id)
      expect(invoice).to have_key(:merchant_id)
      expect(invoice).to have_key(:status)
      expect(invoice).to have_key(:created_at)
      expect(invoice).to have_key(:updated_at)
    end
    expect(invoices.count).to eq(4)
  end

  it 'sends invoice by id' do
    id = create(:invoice).id

    get "/api/v1/invoices/#{id}"

    invoice = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(invoice[:id]).to eq(id)
    expect(invoice).to have_key(:id)
    expect(invoice).to have_key(:status)
    expect(invoice).to have_key(:created_at)
    expect(invoice).to have_key(:updated_at)
  end
end
