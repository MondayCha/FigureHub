class DealCommentsController < ApplicationController
  before_action :set_deal
  before_action :set_deal_comment, only: [:update, :destroy]

  # GET /deals/:deal_id/comment
  def index
    @deal_comment = @deal.deal_comment
    json_response(@deal_comment)
  end

  # POST /deals/:deal_id/comment
  def create
    @deal_comment = @deal.create_deal_comment(deal_comment_params)
    json_response(@deal_comment, :created)
  end

  # PUT /deals/:deal_id/comment
  def update
    @deal_comment.update(deal_comment_params)
    head :no_content
  end

  # DELETE /deals/:deal_id/comment
  def destroy
    @deal_comment.destroy
    head :no_content
  end

  private

  def deal_comment_params
    params.permit(:content).merge(user_id: @current_user.id)
  end

  def set_deal
    @deal = Deal.find(params[:deal_id])
  end

  def set_deal_comment
    @deal_comment = @deal.deal_comment
  end
end
