class Character < ApplicationRecord
  belongs_to :origin

  has_many :character_images, dependent: :destroy

  has_many :figure_character_associations, dependent: :destroy
  has_many :figures, through: :figure_character_associations

  validates_presence_of :name, :gender, :info
end
