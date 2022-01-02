require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource "Users" do
  # add requests owner
  let(:user) { build(:user) }
  let(:valid_attributes) { attributes_for(:user) }

  # Headers which should be included in the request
  header 'Accept', 'application/json'
  header "Content-Type", "application/json"

  post "/api/signup" do
    with_options scope: :user, with_example: true do
      parameter :name, 'The User\'s name (also query id)', required: true
      parameter :nickname, 'The User\'s nickname', required: true
      parameter :kind, '0: admin; 1: normal user; 2: company user', required: true
      parameter :avatar, 'User\'s avatar'
      parameter :password, 'User\'s password', required: true
    end

    let(:raw_post) { params.to_json }

    context "201" do
      let(:params) { valid_attributes }
      example "When valid request" do
        explanation "Sign up a new account."

        do_request

        expect(status).to eq(201)
        expect(response_body).to match(/Account created successfully/)
      end
    end

  end
end