class CharactersController < ApplicationController
  before_action :set_character, only: [:show, :update, :destroy]
  skip_before_action :authorize_request, only: [:index, :show]

  # GET /characters
  def index
    @characters = Character.all.map do |p|
      {
        id: p.id,
        name: p.name,
        gender: p.gender,
        info: p.info,
        origin_id: p.origin.id,
        origin_name: p.origin.name,
      }
    end
    json_response(@characters)
  end

  # POST /characters
  def create
    @origin.characters.create!(character_params)
    json_response(@origin, :created)
  end

  # GET characters/:id
  def show
    json_response(@character)
  end

  # PUT /characters/:id
  def update
    @character.update(character_params)
    head :no_content
  end

  # DELETE /characters/:id
  def destroy
    @character.destroy
    head :no_content
  end

  private

  def character_params
    params.permit(:name, :gender, :info, :origin_id)
  end

  def set_character
    @character = Character.find(params[:id])
  end
end
