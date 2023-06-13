require 'rails_helper'

RSpec.describe RoadTripSerializer, type: :serializer do
  it 'can serialize roadtrips' do
    road_trip = File.read('spec/fixtures/roadtrip.json')
    road_trip = JSON.parse(road_trip, symbolize_names: true)

    forecast = File.read('spec/fixtures/la_forecast.json')
    forecast = JSON.parse(forecast, symbolize_names: true)

    serialized = RoadTripSerializer.new(road_trip, forecast).serialize
    expect(serialized).to be_a(Hash)
    expect(serialized).to have_key(:data)
    expect(serialized[:data]).to be_a(Hash)
    expect(serialized[:data]).to have_key(:id)
    expect(serialized[:data][:id]).to eq(nil)
    expect(serialized[:data]).to have_key(:type)
    expect(serialized[:data][:type]).to eq('road_trip')
    expect(serialized[:data]).to have_key(:attributes)
    expect(serialized[:data][:attributes]).to be_a(Hash)
    expect(serialized[:data][:attributes]).to have_key(:start_city)
    expect(serialized[:data][:attributes][:start_city]).to be_a(String)
    expect(serialized[:data][:attributes]).to have_key(:end_city)
    expect(serialized[:data][:attributes][:end_city]).to be_a(String)
    expect(serialized[:data][:attributes]).to have_key(:travel_time)  
    expect(serialized[:data][:attributes][:travel_time]).to be_a(String)
    expect(serialized[:data][:attributes]).to have_key(:weather_at_eta)
    expect(serialized[:data][:attributes][:weather_at_eta]).to be_a(Hash)
    expect(serialized[:data][:attributes][:weather_at_eta]).to have_key(:temperature)
    expect(serialized[:data][:attributes][:weather_at_eta][:temperature]).to be_a(Float)
    expect(serialized[:data][:attributes][:weather_at_eta]).to have_key(:conditions)
    expect(serialized[:data][:attributes][:weather_at_eta][:conditions]).to be_a(String)
  end

  it 'can serialize errors' do
    params = {origin: "denver,CO", destination: "london,uk"}

    road_trip = File.read('spec/fixtures/roadtrip.json')
    road_trip = JSON.parse(road_trip, symbolize_names: true)

    serialized = RoadTripSerializer.new(road_trip,nil,params).error

    expect(serialized).to be_a(Hash)
    expect(serialized).to have_key(:data)
    expect(serialized[:data]).to be_a(Hash)
    expect(serialized[:data]).to have_key(:id)
    expect(serialized[:data][:id]).to eq(nil)
    expect(serialized[:data]).to have_key(:type)
    expect(serialized[:data][:type]).to eq('road_trip')
    expect(serialized[:data]).to have_key(:attributes)
    expect(serialized[:data][:attributes]).to be_a(Hash)
    expect(serialized[:data][:attributes]).to have_key(:start_city)
    expect(serialized[:data][:attributes][:start_city]).to be_a(String)
    expect(serialized[:data][:attributes]).to have_key(:end_city)
    expect(serialized[:data][:attributes][:end_city]).to be_a(String)
    expect(serialized[:data][:attributes]).to have_key(:travel_time)  
    expect(serialized[:data][:attributes][:travel_time]).to be_a(String)
    expect(serialized[:data][:attributes][:travel_time]).to eq("impossible")
    expect(serialized[:data][:attributes]).to have_key(:weather_at_eta)
    expect(serialized[:data][:attributes][:weather_at_eta]).to be_a(Hash)
    expect(serialized[:data][:attributes][:weather_at_eta]).to eq({})
  end
end