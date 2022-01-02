class MerchandisesController < ApplicationController
  before_action :set_merchandise, except: [:index, :create, :search, :select]
  skip_before_action :authorize_request, only: [:index, :show]

  # GET /merchandises
  def index
    @merchandises = Merchandise.all
    json_response(@merchandises)
  end

  # GET /merchandises/:id
  def show
    json_response(@merchandise)
  end

  # POST /merchandises
  def create
    @merchandise = Merchandise.create!(merchandise_params)
    json_response(@merchandise, :created)
  end

  # PUT /merchandises/:id
  def update
    @merchandise.update(merchandise_params)
    head :no_content
  end

  # DELETE /merchandises/:id
  def destroy
    @merchandise.destroy
    head :no_content
  end

  # GET /search/merchandises
  def search
    search_column, search_param = nil, nil
    if merchandise_params[:kind]
      search_column, search_param = 'kind', merchandise_params[:kind]
    elsif merchandise_params[:price]
      search_column, search_param = 'price', merchandise_params[:price]
    end

    if search_column
      @merchandises = Merchandise.where("#{search_column} like ?", "%#{search_param}%")
      json_response_without_time(@merchandises)
    else
      json_response_without_time(Merchandise.all)
    end
  end

  def select
    if params[:user_name]
      @merchandises = Merchandise.joins(:user).where('users.name' => params[:user_name])
      json_response(@merchandises)
    end
  end

  private

  def merchandise_params
    params.permit(:price, :status, :kind).merge(user_id: @current_user.id)
  end

  def set_merchandise
    @merchandise = Merchandise.find(params[:id])
  end
end
