require 'rails_helper'

RSpec.feature "Backend Service", vcr: { record: :new_episodes } do
  describe "get_books" do
    it "can get books" do
      response = LibraryService.new.get_books("denver,co",5)

      expect(response).to be_a(Hash)
      expect(response).to have_key(:numFound)
      expect(response).to have_key(:docs)
      expect(response[:docs]).to be_an(Array)
      expect(response[:docs].count).to eq(5)
      expect(response[:docs].first).to have_key(:title)
      expect(response[:docs].first[:title]).to be_a(String)
    end
  end
end
