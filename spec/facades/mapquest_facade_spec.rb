require 'rails_helper'

RSpec.feature "MapquestFacade" , :vcr do
  it "coords" do
    params = {location: "denver,CO"}
    response = MapquestFacade.new(params).coords
    expect(response).to be_a(Hash)
    expect(response).to have_key(:lat)
    expect(response).to have_key(:lng)

    expect(response).to_not have_key(:results)
    expect(response).to_not have_key(:data)
  end

  it "road_trip" do
    params = {origin: "denver,CO", destination: "pueblo,CO"}
    response = MapquestFacade.new(params).road_trip

    expect(response).to be_a(Hash)
    expect(response).to have_key(:route)
    expect(response[:route]).to have_key(:distance)
    expect(response[:route]).to have_key(:formattedTime)
  end
end