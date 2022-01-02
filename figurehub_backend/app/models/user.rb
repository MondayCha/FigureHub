class User < ApplicationRecord
  has_secure_password

  has_many :merchandises, dependent: :destroy
  has_many :figure_comments, dependent: :destroy
  has_many :deal_comments, dependent: :destroy
  has_many :deals, dependent: :destroy

  validates_presence_of :name, :nickname, :kind, :password_digest
end
