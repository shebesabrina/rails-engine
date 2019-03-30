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
end
