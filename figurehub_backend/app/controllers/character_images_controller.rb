class CharacterImagesController < ApplicationController
  before_action :set_character
  before_action :set_character_image, only: [:show, :update, :destroy]
  skip_before_action :authorize_request, only: [:index, :show]

  # GET /characters/:character_id/character_images
  def index
    @character_images = @character.character_images.all
    json_response(@character_images)
  end

  # POST /characters/:character_id/character_images
  def create
    image_types = params[:image].content_type.split('/')
    if image_types[0] == 'image' and image_types[1]
      dir = "#{Rails.configuration.x.img_path.base}#{Rails.configuration.x.img_path.character}/#{@character.id}"
      FileUtils.mkdir_p(dir, :mode => 0777) unless File.directory?(dir)
      image_path = "#{Rails.configuration.x.img_path.character}/#{@character.id}/#{params[:image].original_filename}"
      file_path = "#{dir}/#{params[:image].original_filename}"

      File.open(file_path, "wb") do |f|
        f.write(params[:image].read)
      end

      @character_image = CharacterImage.create!({ url: image_path, character_id: @character.id })
      json_response(@character_image, :created)
    else
      head :no_content
    end
  end

  # GET /characters/:character_id/character_images/:id
  def show
    json_response(@character_image)
  end

  # PUT /characters/:character_id/character_images/:id
  def update
    @character_image.update(character_image_params)
    head :no_content
  end

  # DELETE /characters/:character_id/character_images/:id
  def destroy
    @character_image.destroy
    head :no_content
  end

  private

  def character_image_params
    params.permit(:url)
  end

  def set_character
    @character = Character.find(params[:character_id])
  end

  def set_character_image
    @character_image = @character.character_images.find_by!(id: params[:id]) if @character
  end
end
