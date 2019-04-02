require 'rails_helper'

describe 'Transactions API' do
  it 'sends a list of transactions' do
    create_list(:transaction, 6)

    get '/api/v1/transactions'

    expect(response).to be_successful

    transactions = JSON.parse(response.body, symbolize_names: true)

    transactions.each do |transaction|
      expect(transaction).to have_key(:id)
      expect(transaction).to have_key(:invoice_id)
      expect(transaction).to have_key(:credit_card_number)
      expect(transaction).to have_key(:credit_card_expiraton_date)
      expect(transaction).to have_key(:result)
      expect(transaction).to have_key(:created_at)
      expect(transaction).to have_key(:updated_at)
    end

    expect(transactions.count).to eq(6)
  end

  it 'sends a transaction by id' do
    id = create(:transaction)

    get "/api/v1/transactions/#{id}"

    expect(response).to be_successful

    transaction = JSON.parse(response.body, symbolize_names: true)
    expect(transaction[:id]).to eq(id)
    expect(transaction).to have_key(:id)
    expect(transaction).to have_key(:invoice_id)
    expect(transaction).to have_key(:credit_card_number)
    expect(transaction).to have_key(:credit_card_expiraton_date)
    expect(transaction).to have_key(:result)
    expect(transaction).to have_key(:created_at)
    expect(transaction).to have_key(:updated_at)
  end
end
