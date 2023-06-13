require 'rails_helper'

RSpec.describe "RoadTrip requests", :vcr do
  describe "create" do
    before :each do
      user = User.create(email: "test@gmail.com", password: "password", password_confirmation: "password", api_key: "xxx")
    end
    it "can create a roadtrip" do
      params = {
        origin: "New York, NY",
        destination: "Los Angeles, CA",
        api_key: "xxx"
      }

      post "/api/v0/road_trip", params: params
      json = JSON.parse(response.body, symbolize_names: true)
      expect(response).to be_successful
      expect(response.status).to eq(200)

      expect(json).to be_a(Hash)
      expect(json).to have_key(:data)
      expect(json[:data]).to be_a(Hash)
      expect(json[:data]).to have_key(:type)
      expect(json[:data][:type]).to be_a(String)
      expect(json[:data]).to have_key(:id)
      expect(json[:data]).to have_key(:attributes)
      expect(json[:data][:attributes]).to be_a(Hash)

      expect(json[:data][:attributes]).to have_key(:start_city)
      expect(json[:data][:attributes][:start_city]).to be_a(String)
      expect(json[:data][:attributes][:start_city]).to eq(params[:origin])
      
      expect(json[:data][:attributes]).to have_key(:end_city)
      expect(json[:data][:attributes][:end_city]).to be_a(String)
      expect(json[:data][:attributes][:end_city]).to eq(params[:destination])

      expect(json[:data][:attributes]).to have_key(:travel_time)
      expect(json[:data][:attributes][:travel_time]).to be_a(String)
      
      expect(json[:data][:attributes]).to have_key(:weather_at_eta)
      expect(json[:data][:attributes][:weather_at_eta]).to be_a(Hash)
      expect(json[:data][:attributes][:weather_at_eta]).to have_key(:temperature)
      expect(json[:data][:attributes][:weather_at_eta][:temperature]).to be_a(Float)
      expect(json[:data][:attributes][:weather_at_eta]).to have_key(:conditions)
      expect(json[:data][:attributes][:weather_at_eta][:conditions]).to be_a(String)
      expect(json[:data][:attributes][:weather_at_eta]).to have_key(:datetime)
      expect(json[:data][:attributes][:weather_at_eta][:datetime]).to be_a(String)
    end

    it "can't create a roadtrip with an invalid api key" do
      params = {
        origin: "New York, NY",
        destination: "Los Angeles, CA",
        api_key: "wrong"
      }

      post "/api/v0/road_trip", params: params
      expect(response.status).to eq(401)
      json = JSON.parse(response.body, symbolize_names: true)
      expect(json).to be_a(Hash)
      expect(json).to have_key(:error)
      expect(json[:error]).to eq("Unauthorized API Key")
    end

    it "throws error with an invalid destination" do
      params = {
        origin: "New York, NY",
        destination: "London, UK",
        api_key: "xxx"
      }

      post "/api/v0/road_trip", params: params
      json = JSON.parse(response.body, symbolize_names: true)
      expect(response.status).to eq(200)
      expect(json).to be_a(Hash)
      expect(json).to have_key(:data)
      expect(json[:data]).to be_a(Hash)
      expect(json[:data]).to have_key(:type)
      expect(json[:data][:type]).to be_a(String)
      expect(json[:data]).to have_key(:id)
      expect(json[:data]).to have_key(:attributes)
      expect(json[:data][:attributes]).to be_a(Hash)
      expect(json[:data][:attributes]).to have_key(:start_city)
      expect(json[:data][:attributes][:start_city]).to be_a(String)
      expect(json[:data][:attributes][:start_city]).to eq(params[:origin])
      expect(json[:data][:attributes]).to have_key(:end_city)
      expect(json[:data][:attributes][:end_city]).to be_a(String)
      expect(json[:data][:attributes][:end_city]).to eq(params[:destination])
      expect(json[:data][:attributes]).to have_key(:travel_time)
      expect(json[:data][:attributes][:travel_time]).to be_a(String)
      expect(json[:data][:attributes][:travel_time]).to eq("impossible")

      expect(json[:data][:attributes]).to have_key(:weather_at_eta)
      expect(json[:data][:attributes][:weather_at_eta]).to be_a(Hash)
    end
  end
end