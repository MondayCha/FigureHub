class DealComment < ApplicationRecord
  belongs_to :deal
  belongs_to :user

  validates_presence_of :content
end
