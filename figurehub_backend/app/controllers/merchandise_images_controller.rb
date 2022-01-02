class MerchandiseImagesController < ApplicationController
  before_action :set_merchandise
  before_action :set_merchandise_image, only: [:show, :update, :destroy]
  skip_before_action :authorize_request, only: [:index, :show]

  # GET /merchandises/:merchandise_id/merchandise_images
  def index
    @merchandise_images = @merchandise.merchandise_images.all
    json_response(@merchandise_images)
  end

  # POST /merchandises/:merchandise_id/merchandise_images
  def create
    image_types = params[:image].content_type.split('/')
    if image_types[0] == 'image' and image_types[1]
      dir = "#{Rails.configuration.x.img_path.base}#{Rails.configuration.x.img_path.merchandise}/#{@merchandise.id}"
      FileUtils.mkdir_p(dir, :mode => 0777) unless File.directory?(dir)
      image_path = "#{Rails.configuration.x.img_path.merchandise}/#{@merchandise.id}/#{params[:image].original_filename}"
      file_path = "#{dir}/#{params[:image].original_filename}"

      File.open(file_path, "wb") do |f|
        f.write(params[:image].read)
      end

      @merchandise_image = MerchandiseImage.create!({ url: image_path, merchandise_id: @merchandise.id })
      json_response(@merchandise_image, :created)
    else
      head :no_content
    end
  end

  # GET /merchandises/:merchandise_id/merchandise_images/:id
  def show
    json_response(@merchandise_image)
  end

  # PUT /merchandises/:merchandise_id/merchandise_images/:id
  def update
    @merchandise_image.update(merchandise_image_params)
    head :no_content
  end

  # DELETE /merchandises/:merchandise_id/merchandise_images/:id
  def destroy
    @merchandise_image.destroy
    head :no_content
  end

  private

  def merchandise_image_params
    params.permit(:url)
  end

  def set_merchandise
    @merchandise = Merchandise.find(params[:merchandise_id])
  end

  def set_merchandise_image
    @merchandise_image = @merchandise.merchandise_images.find_by!(id: params[:id]) if @merchandise
  end
end
