require 'rails_helper'

RSpec.feature "MapquestFacade" do
  it "coords" do
    params = {location: "denver,CO"}
    response = MapquestFacade.new(params).coords
    expect(response).to be_a(Hash)
    expect(response).to have_key(:lat)
    expect(response).to have_key(:lng)

    expect(response).to_not have_key(:results)
    expect(response).to_not have_key(:data)
  end
end