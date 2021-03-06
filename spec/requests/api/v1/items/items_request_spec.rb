require 'rails_helper'

describe 'Items API' do
  it 'Sends all items' do
    create_list(:item, 3)

    get '/api/v1/items'

    expect(response).to be_successful
    expect(response.status).to eq(200)

    items = JSON.parse(response.body, symbolize_names: true)
    expect(items.count).to eq(3)
    expect(items[0]).to have_key(:id)
    expect(items[0]).to have_key(:name)
    expect(items[0]).to have_key(:description)
    expect(items[0]).to have_key(:merchant_id)
    expect(items[0]).to have_key(:created_at)
    expect(items[0]).to have_key(:updated_at)
  end

  it 'Sends item by id' do
    id =  create(:item).id

    get "/api/v1/items/#{id}"

    item =  JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(item[:id]).to eq(id)
    expect(item).to have_key(:name)
    expect(item).to have_key(:description)
    expect(item).to have_key(:merchant_id)
    expect(item).to have_key(:created_at)
    expect(item).to have_key(:updated_at)
  end

  it "can create a new item" do
    merchant_id = create(:merchant).id
    item_params = { name: "Saw", description: "I want to play a game.",
                    merchant_id: merchant_id }

    post "/api/v1/items", params: { item: item_params }
    item = Item.last

    expect(response).to be_successful
    expect(item.name).to eq(item_params[:name])
    expect(item.description).to eq(item_params[:description])
  end

  it "can update an existing item" do
    id = create(:item).id
    previous_name = Item.last.name
    previous_description = Item.last.description
    item_params = { name: 'Luba', description: 'My dog is scared of the dark' }

    put "/api/v1/items/#{id}", params: { item: item_params }
    item = Item.find_by(id: id)

    expect(response).to be_successful

    expect(item.name).to_not eq(previous_name)
    expect(item.name).to eq("Luba")

    expect(item.description).to_not eq(previous_description)
    expect(item.description).to eq("My dog is scared of the dark")
  end

  it "can destroy an existing item" do
    id = create(:item).id

    expect(Item.count).to eq(1)

    delete "/api/v1/items/#{id}"

    expect(response).to be_successful

    expect(Item.count).to eq(0)
    expect{Item.find(id)}.to raise_error(ActiveRecord::RecordNotFound)
  end
end
