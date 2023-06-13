require 'rails_helper'

RSpec.feature "Mapquest Service" , :vcr do
  describe "get_coords" do
    it "can get lon and lat" do
      response = MapquestService.new.get_coords({location: "denver,co"})

      expect(response).to be_a(Hash)
      expect(response[:results][0][:locations][0][:latLng]).to be_a(Hash)
      expect(response[:results][0][:locations][0][:latLng]).to have_key(:lat)
      expect(response[:results][0][:locations][0][:latLng]).to have_key(:lng)
    end
  end

  describe "get_road_trip" do
    it "can get road trip info" do
      params = {origin: "denver,CO", destination: "pueblo,CO"}

      response = MapquestService.new.get_road_trip(params)
      expect(response).to be_a(Hash)
      expect(response).to have_key(:route)
      expect(response[:route]).to have_key(:distance)
      expect(response[:route]).to have_key(:formattedTime)
    end
  end
end
