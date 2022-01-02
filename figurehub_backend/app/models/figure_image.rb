class FigureImage < ApplicationRecord
  belongs_to :figure
  validates_presence_of :url
end
