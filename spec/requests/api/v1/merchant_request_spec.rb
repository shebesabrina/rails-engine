require 'rails_helper'

describe 'Merchants API' do
  it 'sends all merchants' do
    create_list(:merchant, 3)

    get '/api/v1/merchants'

    expect(response.status).to eq(200)

    merchants = JSON.parse(response.body, symbolize_names: true)

    expect(merchants.count).to eq(3)
    expect(merchants[0]).to have_key(:id)
    expect(merchants[0]).to have_key(:name)
    expect(merchants[0]).to have_key(:created_at)
    expect(merchants[0]).to have_key(:updated_at)
  end

  it 'send merchant by id' do
    id = create(:merchant).id

    get "/api/v1/merchants/#{id}"

    merchant = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(merchant[:id]).to eq(id)
    expect(merchant).to have_key(:id)
    expect(merchant).to have_key(:name)
    expect(merchant).to have_key(:created_at)
    expect(merchant).to have_key(:updated_at)
  end

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
