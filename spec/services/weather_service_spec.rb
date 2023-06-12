require 'rails_helper'

RSpec.feature "Weather Service" do
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
end