class Figure < ApplicationRecord
  belongs_to :company

  has_many :figure_comments, dependent: :destroy

  has_many :figure_images, dependent: :destroy

  has_many :figure_character_associations, dependent: :destroy
  has_many :characters, through: :figure_character_associations

  has_many :sales, dependent: :destroy
  has_many :merchandises, through: :sales

  validates_presence_of :name, :kind, :price, :scale
end
