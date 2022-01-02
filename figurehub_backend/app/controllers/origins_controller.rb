class OriginsController < ApplicationController
  before_action :set_origin, only: [:show, :update, :destroy]
  skip_before_action :authorize_request, only: [:index, :show]

  # GET /origins
  def index
    @origins = Origin.all
    json_response_without_time(@origins)
  end

  # POST /origins
  def create
    @origin = Origin.create!(origin_params)
    json_response_without_time(@origin, :created)
  end

  # GET /origins/:id
  def show
    json_response_without_time(@origin)
  end

  # PUT /origins/:id
  def update
    @origin.update(origin_params)
    head :no_content
  end

  # DELETE /origins/:id
  def destroy
    @origin.destroy
    head :no_content
  end

  private

  def origin_params
    # whitelist params
    params.permit(:name, :kind, :info)
  end

  def set_origin
    @origin = Origin.find(params[:id])
  end
end
