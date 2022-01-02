require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource "Origins" do
  # add requests owner
  let(:user) { create(:user) }
  let(:auth_token) { token_generator(user.id) }
  let!(:origins) { create_list(:origin, 4) }
  let(:origin_id) { origins.first.id }
  # Headers which should be included in the request
  header "Content-Type", "application/json"
  header "Authorization", :auth_token

  get "/api/origins" do
    example "Listing Origins" do
      explanation "Retrieve all of the origins (works)."
      do_request
      expect(status).to eq(200)
    end
  end
end