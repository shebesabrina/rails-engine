require 'rails_helper'

describe 'Merchants API relationships' do
  it 'returns a collection of items associated with that merchant' do
    merchant =  create(:merchant)

    get "/api/v1/merchants/#{merchant.id}/items"

    expect(response).to be_successful

    items = JSON.parse(response.body, symbolize_names: true)

    items.each do |item|
      expect(item['merchant_id'].to eq(merchant.id))
    end
    expect(items).to eq(merchant.items)
  end

  it 'returns all invoices associated with a merchant by id' do
    merchant =  create(:merchant)

    get "/api/v1/merchants/#{merchant.id}/invoices"

    expect(response).to be_successful

    invoices = JSON.parse(response.body, symbolize_names: true)

    invoices.each do |invoice|
      expect(invoice['merchant_id']).to eq(merchant.id)
    end

    expect(invoices).to eq(merchant.items)
  end
end
