require 'rails_helper'

RSpec.describe Origin, type: :model do
  # Association test
  # ensure Origin model has a 1:m relationship with the Character model
  it { should have_many(:characters).dependent(:destroy) }
  # Validation tests
  # ensure columns name, kind and info are present before saving
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:kind) }
  it { should validate_presence_of(:info) }
end
