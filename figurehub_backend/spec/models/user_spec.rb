require 'rails_helper'

RSpec.describe User, type: :model do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:nickname) }
  it { should validate_presence_of(:kind) }
  # it { should validate_presence_of(:token) }
  # it { should validate_presence_of(:avatar) }
  it { should validate_presence_of(:password_digest) }
end
