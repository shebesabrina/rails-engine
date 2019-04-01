require 'rails_helper'

describe 'Invoice Items API' do
  it 'sends all invoice items' do
    create_list(:invoice_item, 5)

    get '/api/v1/invoice_items'

    expect(response).to be_successful

    invoice_items =  JSON.parse(response.body)

    expect(invoice_items.count).to eq(5)
  end

  it 'sends an invoice item by id' do
    id = create(:invoice_item).id

    get "/api/v1/invoice_items/#{id}"

    expect(response).to be_successful

    invoice_item = JSON.parse(response.body, symbolize_names: true)

    expect(invoice_item[:id]).to eq(id)
  end
end
