class FigureCommentsController < ApplicationController
  before_action :set_figure, except: [:select]
  before_action :set_figure_comment, only: [:show, :update, :destroy]
  skip_before_action :authorize_request, only: [:index, :show, :select]

  # GET /figures/:figure_id/figure_comments
  def index
    @figure_comments = @figure.figure_comments.all.map do |p|
      {
        id: p.id,
        comment: p,
        user_name: p.user.name,
      }
    end
    json_response(@figure_comments)
  end

  # POST /figures/:figure_id/figure_comments
  def create
    @figure_comment = @figure.figure_comments.create!(figure_comment_params)
    json_response(@figure_comment, :created)
  end

  # GET /figures/:figure_id/figure_comments/:id
  def show
    json_response(@figure_comment)
  end

  # PUT /figures/:figure_id/figure_comments/:id
  def update
    @figure_comment.update(figure_comment_params)
    head :no_content
  end

  # DELETE /figures/:figure_id/figure_comments/:id
  def destroy
    if @current_user.id == @figure_comment.user_id
      @figure_comment.destroy
    end
    head :no_content
  end

  def select
    if params[:user_name]
      @figure_comments = FigureComment.joins(:user).where('users.name' => params[:user_name]).all.map do |p|
        {
          id: p.id,
          comment: p,
          user_name: p.user.name,
        }
      end
      json_response(@figure_comments)
    end
  end

  private

  def figure_comment_params
    params.permit(:content).merge(user_id: @current_user.id)
  end

  def set_figure
    @figure = Figure.find(params[:figure_id])
  end

  def set_figure_comment
    @figure_comment = @figure.figure_comments.find_by!(id: params[:id]) if @figure
  end
end
