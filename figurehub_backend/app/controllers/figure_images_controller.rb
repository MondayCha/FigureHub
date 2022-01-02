class FigureImagesController < ApplicationController
  before_action :set_figure
  before_action :set_figure_image, only: [:show, :update, :destroy]
  skip_before_action :authorize_request, only: [:index, :show]

  # GET /figures/:figure_id/figure_images
  def index
    @figure_images = @figure.figure_images.all
    json_response(@figure_images)
  end

  # POST /figures/:figure_id/figure_images
  def create
    image_types = params[:image].content_type.split('/')
    if image_types[0] == 'image' and image_types[1]
      dir = "#{Rails.configuration.x.img_path.base}#{Rails.configuration.x.img_path.figure}/#{@figure.id}"
      FileUtils.mkdir_p(dir, :mode => 0777) unless File.directory?(dir)
      image_path = "#{Rails.configuration.x.img_path.figure}/#{@figure.id}/#{params[:image].original_filename}"
      file_path = "#{dir}/#{params[:image].original_filename}"

      File.open(file_path, "wb") do |f|
        f.write(params[:image].read)
      end

      @figure_image = FigureImage.create!({ url: image_path, figure_id: @figure.id })
      json_response(@figure_image, :created)
    else
      head :no_content
    end
  end

  # GET /figures/:figure_id/figure_images/:id
  def show
    json_response(@figure_image)
  end

  # PUT /figures/:figure_id/figure_images/:id
  def update
    @figure_image.update(figure_image_params)
    head :no_content
  end

  # DELETE /figures/:figure_id/figure_images/:id
  def destroy
    @figure_image.destroy
    head :no_content
  end

  private

  def figure_image_params
    params.permit(:url)
  end

  def set_figure
    @figure = Figure.find(params[:figure_id])
  end

  def set_figure_image
    @figure_image = @figure.figure_images.find_by!(id: params[:id]) if @figure
  end
end
