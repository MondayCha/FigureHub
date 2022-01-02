require 'rails_helper'

RSpec.describe Character, type: :model do
  # Association test
  # ensure Origin model has a 1:m relationship with the Character model
  it { should belong_to(:origin) }
  # Validation tests
  # ensure columns name, kind and info are present before saving
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:gender) }
  it { should validate_presence_of(:info) }
end
