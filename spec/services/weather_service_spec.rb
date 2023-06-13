require 'rails_helper'

RSpec.feature "Weather Service" , :vcr do
  describe "get_forecast" do
    it "can get forecast" do
      response = WeatherService.new.get_forecast({lat: 39.738453, lng: -104.984853})
      expect(response).to be_a(Hash)
      expect(response[:location]).to be_a(Hash)
      expect(response[:location]).to have_key(:name)
      expect(response[:location]).to have_key(:region)
      expect(response[:location]).to have_key(:country)
      expect(response[:current]).to be_a(Hash)
      expect(response[:current]).to have_key(:temp_f)
      expect(response[:current]).to have_key(:condition)
      expect(response[:current][:condition]).to be_a(Hash)
      expect(response[:current][:condition]).to have_key(:text)
    end
  end

  describe "get_specific_forecast" do
    it "can get forecast at specific location at specific time" do
      params = {lat: 39.738453, lng: -104.984853}
      travel_time = "24:30:00"

      response = WeatherService.new.get_specific_forecast(params, travel_time)
      expect(response).to have_key(:location)
      expect(response[:location]).to have_key(:name)
      expect(response[:location]).to have_key(:lat)
      expect(response[:location]).to have_key(:lon)
      expect(response).to have_key(:current)
      expect(response[:current]).to have_key(:temp_f)
      expect(response[:current]).to have_key(:condition)
      expect(response[:current]).to have_key(:uv)
      expect(response).to have_key(:forecast)
      expect(response[:forecast]).to have_key(:forecastday)
      expect(response[:forecast][:forecastday][0]).to have_key(:hour)
    end
  end
end