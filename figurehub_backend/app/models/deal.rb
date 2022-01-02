class Deal < ApplicationRecord
  belongs_to :merchandise

  belongs_to :user

  has_one :deal_comment, dependent: :destroy

  validates_presence_of :status
end
