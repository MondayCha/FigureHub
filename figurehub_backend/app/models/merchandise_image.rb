class MerchandiseImage < ApplicationRecord
  belongs_to :merchandise
  validates_presence_of :url
end
