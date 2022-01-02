class CompaniesController < ApplicationController
  before_action :set_company, only: [:show, :update, :destroy, :search]
  skip_before_action :authorize_request, only: [:index, :show]

  # GET /companies
  def index
    @companies = Company.all
    json_response_without_time(@companies)
  end

  # GET /search/companies
  def search
    if company_params[:name]
      @companies = Company.where("name like ?", "%#{company_params[:name]}%")
      json_response_without_time(@companies)
    else
      json_response_without_time(Company.all)
    end
  end

  # POST /companies
  def create
    @company = Company.create!(company_params)
    json_response_without_time(@company, :created)
  end

  # GET /companies/:id
  def show
    json_response_without_time(@company)
  end

  # PUT /companies/:id
  def update
    @company.update(company_params)
    head :no_content
  end

  # DELETE /companies/:id
  def destroy
    @company.destroy
    head :no_content
  end

  private

  def company_params
    # whitelist params
    params.permit(:name, :link)
  end

  def set_company
    @company = Company.find(params[:id])
  end
end
