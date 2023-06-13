require 'rails_helper'

RSpec.describe "Forecast requests", :vcr do
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
      expect(json[:data][:attributes]).to have_key(:hourly_weather)
      
      expect(json[:data][:attributes]).to_not have_key(:temp_c)
      expect(json[:data][:attributes]).to_not have_key(:feelslike_c)
      expect(json[:data][:attributes]).to_not have_key(:localtime)
      expect(json[:data][:attributes]).to_not have_key(:wind_mph)
      expect(json[:data][:attributes]).to_not have_key(:wind_kph)
      expect(json[:data][:attributes]).to_not have_key(:wind_degree)
      expect(json[:data][:attributes]).to_not have_key(:wind_dir)
      expect(json[:data][:attributes]).to_not have_key(:pressure_mb)
      expect(json[:data][:attributes]).to_not have_key(:pressure_in)
      expect(json[:data][:attributes]).to_not have_key(:precip_mm)
      expect(json[:data][:attributes]).to_not have_key(:precip_in)
      expect(json[:data][:attributes]).to_not have_key(:humidity)
      expect(json[:data][:attributes]).to_not have_key(:cloud)
    end
  end
end
