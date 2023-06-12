require 'rails_helper'

RSpec.feature "LibraryFacade" do
  it "books" do
    params = {location: "denver,CO", quantity: 5}
    response = LibraryFacade.new(params).books
    expect(response).to be_a(Hash)
    expect(response).to have_key(:numFound)
    expect(response).to have_key(:docs)
    expect(response[:docs]).to be_an(Array)
    expect(response[:docs].count).to eq(5)
    expect(response[:docs].first).to have_key(:title)
    expect(response[:docs].first[:title]).to be_a(String)
  end
end