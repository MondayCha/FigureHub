class Company < ApplicationRecord
  has_many :figures, dependent: :destroy

  validates_presence_of :name, :link
end
