class Sale < ApplicationRecord
  belongs_to :merchandise
  belongs_to :figure
end
