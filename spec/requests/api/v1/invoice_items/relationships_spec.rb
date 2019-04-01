require 'rails_helper'

describe 'Invoice Items API relationships' do
  it 'returns the associated invoice' do
    ii = create(:invoice_item)

    get "/api/v1/invoice_items/#{ii.id}/invoice"

    expect(response).to be_successful

    invoice = JSON.parse(response.body, symbolize_names: true)

    expect(invoice[:id]).to eq(ii.invoice_id)
  end

  it 'returns the associated item' do
    ii = create(:invoice_item)

    get "/api/v1/invoice_items/#{ii.id}/item"

    expect(response).to be_successful

    item = JSON.parse(response.body, symbolize_names: true)

    expect(item[:id]).to eq(ii.item_id)
  end
end
