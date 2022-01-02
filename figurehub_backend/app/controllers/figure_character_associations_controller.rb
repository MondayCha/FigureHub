class FigureCharacterAssociationsController < ApplicationController
  before_action :set_fc_relation, only: [:show, :update, :destroy]
  skip_before_action :authorize_request, only: [:index, :show, :select]

  # GET /fc_relations
  def index
    @fc_relations = FigureCharacterAssociation.all.map do |p|
      {
        id: p.id,
        figure_id: p.figure.id,
        figure_name: p.figure.name,
        character_id: p.character.id,
        character_name: p.character.name,
      }
    end
    json_response_without_time(@fc_relations)
  end

  # POST /fc_relations
  def create
    @figure_character_association = FigureCharacterAssociation.create!(fc_relation_params)
    json_response_without_time(@figure_character_association, :created)
  end

  # GET /fc_relations/:id
  def show
    json_response_without_time(@figure_character_association)
  end

  # PUT /fc_relations/:id
  def update
    @figure_character_association.update(fc_relation_params)
    head :no_content
  end

  # DELETE /fc_relations/:id
  def destroy
    @figure_character_association.destroy
    head :no_content
  end

  # select by figure or character id
  def select
    if fc_relation_params[:figure_id]
      @data = FigureCharacterAssociation.where(:figure_id => fc_relation_params[:figure_id]).map do |p|
        {
          id: p.id,
          figure: {
            id: p.figure.id,
            scale: p.figure.scale,
            price: p.figure.price,
            name: p.figure.name,
            company: p.figure.company,
          },
          character: {
            id: p.character.id,
            name: p.character.name,
            origin: {
              id: p.character.origin.id,
              name: p.character.origin.name,
            }
          },

        }
      end
      json_response(@data)
    elsif fc_relation_params[:character_id]
      @figures = FigureCharacterAssociation.where(:character_id => fc_relation_params[:character_id]).map do |p|
        {
          id: p.id,
          figure: p.figure,
        }
      end
      json_response(@figures)
    end
  end

  private

  def fc_relation_params
    # whitelist params
    params.permit(:figure_id, :character_id)
  end

  def set_fc_relation
    @figure_character_association = FigureCharacterAssociation.find(params[:id])
  end
end
