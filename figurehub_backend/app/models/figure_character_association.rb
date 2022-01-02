class FigureCharacterAssociation < ApplicationRecord
  belongs_to :figure
  belongs_to :character
end
