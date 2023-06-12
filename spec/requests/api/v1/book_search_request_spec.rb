require 'rails_helper'

RSpec.describe "Booksearch requests" do
  describe "index" do
    it "returns json" do

      get '/api/v1/book-search?location=denver,co&quantity=5'
      json = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(json).to have_key(:data)
      expect(json[:data]).to have_key(:id)
      expect(json[:data]).to have_key(:type)
      expect(json[:data]).to have_key(:attributes)
      expect(json[:data][:attributes]).to have_key(:destination)
      expect(json[:data][:attributes]).to have_key(:forecast)
      expect(json[:data][:attributes]).to have_key(:total_books_found)
      expect(json[:data][:attributes]).to have_key(:books)
    end

    it "return error if quantity missing" do
      get '/api/v1/book-search?location=denver,co'
      json = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq(400)
      expect(json).to have_key(:errors)
      expect(json[:errors]).to eq("Please provide a location and quantity")
    end

    it "return error if location missing" do
      get '/api/v1/book-search?quantity=5'
      json = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq(400)
      expect(json).to have_key(:errors)
      expect(json[:errors]).to eq("Please provide a location and quantity")
    end
  end
end