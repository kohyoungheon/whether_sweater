require 'rails_helper'

RSpec.feature "Mapquest Service" do
  describe "get_coords" do
    it "can get lon and lat" do
      response = MapquestService.new.get_coords({location: "denver,co"})

      expect(response).to be_a(Hash)
      expect(response[:results][0][:locations][0][:latLng]).to be_a(Hash)
      expect(response[:results][0][:locations][0][:latLng]).to have_key(:lat)
      expect(response[:results][0][:locations][0][:latLng]).to have_key(:lng)
    end
  end
end
