require 'rails_helper'

describe 'Items API relationships' do
  it 'returns a collection of associated invoice items' do
    item = create(:item)

    get "/api/v1/items/#{item.id}/invoice_items"

    expect(response).to be_successful

    invoice_item = JSON.parse(response.body)

    expect(invoice_item).to eq(item.invoice_items)
  end
end
