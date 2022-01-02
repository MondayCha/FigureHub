class FigureComment < ApplicationRecord
  belongs_to :figure
  belongs_to :user

  validates_presence_of :content
end
