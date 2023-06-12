require 'rails_helper'

RSpec.describe "Forecast requests" do
  describe "index" do
    it "returns json" do
      get '/api/v0/forecast?location=denver,co'
      json = JSON.parse(response.body, symbolize_names: true)
      expect(response).to be_successful
      
      expect(json).to have_key(:data)
      expect(json[:data]).to have_key(:id)
      expect(json[:data]).to have_key(:type)
      expect(json[:data]).to have_key(:attributes)
      expect(json[:data][:attributes]).to have_key(:current_weather)
      expect(json[:data][:attributes]).to have_key(:daily_weather)
    end
  end
end
