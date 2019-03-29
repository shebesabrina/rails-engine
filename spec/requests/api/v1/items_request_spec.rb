require 'rails_helper'

describe 'Items API' do
  it 'Sends all items' do
    create_list(:item, 3)

    get '/api/v1/items'

    expect(response).to be_successful

    items = JSON.parse(response.body)
    expect(items.count).to eq(3)
  end

  it 'Sends item by id' do
    id =  create(:item).id

    get "/api/v1/items/#{id}"

    item =  JSON.parse(response.body)

    expect(response).to be_successful
    expect(item["id"]).to eq(id)
  end
end
