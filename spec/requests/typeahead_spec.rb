# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Typeaheads', type: :request do
  describe 'GET /typeahead/:prefix' do
    before(:all) do
      DummyNamesHelper.short_list
    end
    context 'the prefix not match wit any name' do
      it 'return an empty array' do
        get '/typeahead/notarealname'

        json = JSON.parse(response.body)

        expect(response).to have_http_status(:ok)
        expect(json.size).to eq(0)
      end
    end

    context 'not sending prefix param' do
      it 'return top rated names' do
        get '/typeahead/'
        json = JSON.parse(response.body)

        expect(response).to have_http_status(:ok)
        expect(json.size).to eq(5)
        expect(json[0]['name']).to eq('Sergia')
        expect(json[1]['name']).to eq('Sergio')
        expect(json[2]['name']).to eq('Fabi')
      end
    end

    context 'The prefix match perfect with a name' do
      it 'return first the exact match and then top rated names' do
        get '/typeahead/Fa'
        json = JSON.parse(response.body)

        expect(response).to have_http_status(:ok)
        expect(json.size).to be <= 5
        expect(json[0]['name']).to eq('Fa')
        expect(json[1]['name']).to eq('Fabi')
      end
    end

    context 'The prefix is not an exact match prefix' do
      it 'return the matching words, sorted by times desc' do
        get '/typeahead/fab'
        json = JSON.parse(response.body)

        expect(response).to have_http_status(:ok)
        expect(json.size).to eq(5)
        expect(json.first['name']).to eq('Fabi')
      end
    end

    context 'Different case in prefix' do
      it 'return the same matching names' do
        get '/typeahead/Fabi'
        json = JSON.parse(response.body)

        expect(response).to have_http_status(:ok)
        expect(json.size).to eq(4)
        expect(json[0]['name']).to eq('Fabi')
        expect(json[1]['name']).to eq('Fabio')

        get '/typeahead/fabi'
        json = JSON.parse(response.body)
        expect(response).to have_http_status(:ok)
        expect(json.size).to eq(4)
        expect(json[0]['name']).to eq('Fabi')
        expect(json[1]['name']).to eq('Fabio')

        get '/typeahead/fAbi'
        json = JSON.parse(response.body)
        expect(response).to have_http_status(:ok)
        expect(json.size).to eq(4)
        expect(json[0]['name']).to eq('Fabi')
        expect(json[1]['name']).to eq('Fabio')

        get '/typeahead/FABI'
        json = JSON.parse(response.body)
        expect(response).to have_http_status(:ok)
        expect(json.size).to eq(4)
        expect(json[0]['name']).to eq('Fabi')
        expect(json[1]['name']).to eq('Fabio')
      end
    end

    context 'Response with spaces and hiphens in prefix' do
      it 'return the matching names' do
        get '/typeahead/Fabio-Enzo'
        json = JSON.parse(response.body)

        expect(response).to have_http_status(:ok)
        expect(json.size).to eq(1)
        expect(json[0]['name']).to eq('Fabio-enzo')

        get '/typeahead/FaBio%20VacCaro'
        json = JSON.parse(response.body)
        expect(response).to have_http_status(:ok)
        expect(json.size).to eq(1)
        expect(json[0]['name']).to eq('Fabio Vaccaro')
      end
    end
  end

  describe 'POST /typeahead' do
    before(:all) do
      DummyNamesHelper.short_list
    end
    context 'the name was not found' do
      it 'return an empty array' do
        post '/typeahead', params: { 'name': 'Joannna' }

        json = JSON.parse(response.body)
        expect(response).to have_http_status(:bad_request)
        expect(json['errors']['error']).to eq('Bad Request')
      end
    end

    context 'The name was found with case insensitive search' do
      it 'return the updated name' do
        post '/typeahead', params: { 'name': 'Fabio' }

        json = JSON.parse(response.body)
        expect(response).to have_http_status(:created)
        expect(json['name']).to eq('Fabio')
        expect(json['times']).to eq(35)

        post '/typeahead', params: { 'name': 'Fabio' }
        json = JSON.parse(response.body)
        expect(json['times']).to eq(36)
      end

      it 'return te updated result after changeit' do
        post '/typeahead', params: { 'name': 'Fabio' }
        post '/typeahead', params: { 'name': 'Fabio' }
        post '/typeahead', params: { 'name': 'Fabio' }
        post '/typeahead', params: { 'name': 'Fabio' }

        json = JSON.parse(response.body)
        expect(response).to have_http_status(:created)
        expect(json['name']).to eq('Fabio')
        expect(json['times']).to eq(40)

        get '/typeahead/FABI'
        json = JSON.parse(response.body)
        expect(response).to have_http_status(:ok)
        expect(json.size).to eq(4)
        expect(json[0]['name']).to eq('Fabi')
        expect(json[1]['name']).to eq('Fabio')
        expect(json[1]['times']).to eq(40)
      end
    end
  end
end
