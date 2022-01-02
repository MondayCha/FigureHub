class SalesController < ApplicationController
  before_action :set_sale, only: [:show, :update, :destroy]
  skip_before_action :authorize_request, only: [:index, :search, :show]

  # GET /sales
  def index
    @sales = Sale.all.map do |p|
      {
        id: p.id,
        figure: p.figure,
        merchandise: p.merchandise,
        seller_name: p.merchandise.user.nickname,
        seller_id: p.merchandise.user.name,
        seller_avatar: p.merchandise.user.avatar,
      }
    end
    json_response_without_time(@sales)
  end

  # POST /sales
  def create
    @sale = Sale.create!(sale_params)
    json_response_without_time(@sale, :created)
  end

  # GET /sales/:id
  def show
    json_response_without_time(@sale)
  end

  # PUT /sales/:id
  def update
    @sale.update(sale_params)
    head :no_content
  end

  # DELETE /sales/:id
  def destroy
    @sale.destroy
    head :no_content
  end

  # SEARCH /search/sales
  def search
    if params[:figure_name]
      @sales = Sale.joins(:figure).where("figures.name like ?", "%#{params[:figure_name]}%").map do |p|
        {
          id: p.id,
          figure: p.figure,
          merchandise: p.merchandise,
          seller_name: p.merchandise.user.nickname,
          seller_id: p.merchandise.user.name,
          seller_avatar: p.merchandise.user.avatar,
        }
      end
      json_response_without_time(@sales)
    else
      json_response_without_time(Sale.all)
    end
  end

  private

  def sale_params
    # whitelist params
    params.permit(:figure_id, :merchandise_id)
  end

  def set_sale
    @sale = Sale.find(params[:id])
  end
end
