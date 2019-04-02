require 'rails_helper'

describe 'Customers API' do
  it 'sends a list of all customers' do
    create_list(:customer, 7)

    get '/api/v1/customers'

    expect(response).to be_successful

    customers = JSON.parse(response.body, symbolize_names: true)
    customers.each do |customer|
      expect(customer).to have_key(:id)
      expect(customer).to have_key(:first_name)
      expect(customer).to have_key(:last_name)
      expect(customer).to have_key(:created_at)
      expect(customer).to have_key(:updated_at)
    end

    expect(customers.count).to eq(7)
  end

  it 'sends a customer by id' do
    id = create(:customer).id

    get "/api/v1/customers/#{id}"

    expect(response).to be_successful

    customer = JSON.parse(response.body, symbolize_names: true)

    expect(customer[:id]).to eq(id)
    expect(customer).to have_key(:id)
    expect(customer).to have_key(:first_name)
    expect(customer).to have_key(:last_name)
    expect(customer).to have_key(:created_at)
    expect(customer).to have_key(:updated_at)
  end
end
