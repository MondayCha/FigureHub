class Merchandise < ApplicationRecord
  belongs_to :user

  has_one :sale, dependent: :destroy
  has_one :figure, through: :sale

  has_many :deals, dependent: :destroy

  has_many :merchandise_images, dependent: :destroy

  validates_presence_of :price, :status, :kind
end
