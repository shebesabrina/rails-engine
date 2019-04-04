class Api::V1::Merchants::RevenueController < ApplicationController
  def index
    render json: Merchant.most_revenue(search_params[:quantity])
  end

  private

  def search_params
    params.permit(:quantity)
  end
end
