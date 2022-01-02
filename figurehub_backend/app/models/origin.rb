class Origin < ApplicationRecord
  has_many :characters, dependent: :destroy
  validates_presence_of :name, :kind, :info
end
