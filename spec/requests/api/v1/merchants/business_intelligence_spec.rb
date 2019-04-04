require 'rails_helper'

describe 'Merchants business intelligence API' do

  it 'returns the top x merchants ranked by total revenue' do

    merchant_1 = create(:merchant, name: "Luba")
    merchant_2 = create(:merchant, name: "Coffee")
    merchant_3 = create(:merchant, name: "Lamp")

    item_1 = create(:item, unit_price: 1, merchant: merchant_1)
    item_2 = create(:item, unit_price: 2, merchant: merchant_2)
    item_3 = create(:item, unit_price: 3, merchant: merchant_3)

    invoice_1 = create(:invoice, merchant: merchant_1)
    invoice_2 = create(:invoice, merchant: merchant_2)
    invoice_3 = create(:invoice, merchant: merchant_3)

    invoice_1.items << item_1
    invoice_2.items << item_2
    invoice_3.items << item_3

    transaction_1 = create(:transaction, invoice_id: invoice_1.id)
    transaction_2 = create(:transaction, invoice_id: invoice_2.id)
    transaction_3 = create(:transaction, invoice_id: invoice_3.id)

    get "/api/v1/merchants/most_revenue?quantity=2"

    merchants = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_success
    expect(merchants.count).to eq(2)
    expect(merchants[0]).to have_value(merchant_1.id)
    expect(merchants[1]).to have_value(merchant_2.id)
  end
end
