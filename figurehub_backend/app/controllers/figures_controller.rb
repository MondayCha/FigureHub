class FiguresController < ApplicationController
  before_action :set_figure, except: [:index, :create, :search]
  skip_before_action :authorize_request, only: [:index, :show]

  # GET /figures
  def index
    @figures = Figure.all
    json_response(@figures)
  end

  # GET /figures/:id
  def show
    json_response(@figure)
  end

  # POST /figures
  def create
    @figure = Figure.create!(figure_params)
    json_response(@figure, :created)
  end

  # PUT /figures/:id
  def update
    @figure.update(figure_params)
    head :no_content
  end

  # DELETE /companies/:company_id/figures/:id
  def destroy
    @figure.destroy
    head :no_content
  end

  # GET /search/figures
  def search
    search_column, search_param = nil, nil
    if figure_params[:name]
      search_column, search_param = 'name', figure_params[:name]
    elsif figure_params[:kind]
      search_column, search_param = 'kind', figure_params[:kind]
    elsif figure_params[:price]
      search_column, search_param = 'price', figure_params[:price]
    elsif figure_params[:scale]
      search_column, search_param = 'scale', figure_params[:scale]
    elsif params[:company]
      # join table
      @figures = Figure.joins(:company).where("companies.name like ?", "%#{params[:company]}%")
      json_response_without_time(@figures)
      return
    end

    if search_column
      @figures = Figure.where("#{search_column} like ?", "%#{search_param}%")
      json_response_without_time(@figures)
    else
      json_response_without_time(Figure.all)
    end
  end

  private

  def figure_params
    params.permit(:name, :kind, :price, :scale, :company_id)
  end

  def set_figure
    @figure = Figure.find(params[:id])
  end
end
