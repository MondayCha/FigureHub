require 'rails_helper'

RSpec.describe 'Origins API', type: :request do
  # add todos owner
  let(:user) { create(:user) }
  let!(:origins) { create_list(:origin, 10) }
  let(:origin_id) { origins.first.id }
  # authorize request
  let(:headers) { valid_headers }

  # Test suite for GET /api/origins
  describe 'GET /api/origins' do
    # make HTTP get request before each example
    before { get '/api/origins', params: {}, headers: headers }

    it 'returns origins' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /api/origins/:id
  describe 'GET /api/origins/:id' do
    before { get "/api/origins/#{origin_id}", params: {}, headers: headers }

    context 'when the record exists' do
      it 'returns the origin' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(origin_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:origin_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Origin/)
      end
    end
  end

  # Test suite for POST /api/origins
  describe 'POST /api/origins' do
    # valid payload
    let(:valid_attributes) do
       { name: 'Oregairu', kind: '1', info: 'Hikigaya Hachiman' }.to_json
    end

    context 'when the request is valid' do
      before { post '/api/origins', params: valid_attributes, headers: headers }

      it 'creates a origin' do
        expect(json['name']).to eq('Oregairu')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/api/origins', params: { name: 'Foobar' }.to_json, headers: headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: Kind can't be blank, Info can't be blank/)
      end
    end
  end

  # Test suite for PUT /api/origins/:id
  describe 'PUT /api/origins/:id' do
    let(:valid_attributes) { { kind: '0' }.to_json }

    context 'when the record exists' do
      before { put "/api/origins/#{origin_id}", params: valid_attributes, headers: headers }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for DELETE /api/origins/:id
  describe 'DELETE /api/origins/:id' do
    before { delete "/api/origins/#{origin_id}", params: {}, headers: headers }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end