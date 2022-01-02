class CharacterImage < ApplicationRecord
  belongs_to :character
  validates_presence_of :url
end
