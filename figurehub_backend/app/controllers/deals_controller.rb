class DealsController < ApplicationController
  before_action :set_deal, only: [:show, :update, :destroy]

  # GET /deals
  def index
    @deals = Deal.all
    json_response(@deals)
  end

  # POST /deals
  def create
    @deal = Deal.create!(deal_params)
    left = @deal.merchandise.status - 1
    if left < 0
      @deal.destroy
      json_response({ message: 'no merchandise' }, :bad_request)
    else
      @merchandise = @deal.merchandise
      @merchandise.status = left
      @merchandise.save
      json_response(@deal, :created)
    end
  end

  # GET /deals/:id
  def show
    json_response(@deal)
  end

  # PUT /deals/:id
  def update
    # only able to update status info.
    @deal.update(params.permit(:status))
    head :no_content
  end

  # DELETE /deals/:id
  def destroy
    @deal.destroy
    head :no_content
  end

  # SELECT /select/deals
  def select
    if params[:seller_name]
      @deals = Deal.joins(:merchandise).where('merchandises.user_id' => @current_user.id).map do |p|
        {
          id: p.id,
          buyer_name: p.user.nickname,
          figure_name: p.merchandise.figure.name,
          created_at: p.created_at,
          status: p.status,
        }
      end
      json_response(@deals)
    else
      @deals = Deal.where(user_id: @current_user.id).map do |p|
        {
          id: p.id,
          seller_name: p.merchandise.user.nickname,
          figure_name: p.merchandise.figure.name,
          created_at: p.created_at,
          status: p.status,
        }
      end
      json_response(@deals)
    end
  end

  private

  def deal_params
    # whitelist params
    params.permit(:status, :merchandise_id).merge(user_id: @current_user.id)
  end

  def set_deal
    @deal = Deal.find(params[:id])
  end
end
