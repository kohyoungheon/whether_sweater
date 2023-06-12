require 'rails_helper'

RSpec.feature "WeatherFacade" do
  it "forecast" do
    params = {:lat=>39.74001, :lng=>-104.99202}
    response = WeatherFacade.new(params).forecast
    expect(response).to be_a(Hash)
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
    expect(response[:forecast][:forecastday].first).to have_key(:date)
    expect(response[:forecast][:forecastday].first).to have_key(:day)
    expect(response[:forecast][:forecastday].first[:day]).to have_key(:maxtemp_f)
    expect(response[:forecast][:forecastday].first[:day]).to have_key(:mintemp_f)
    expect(response[:forecast][:forecastday].first[:day]).to have_key(:condition)
    expect(response[:forecast][:forecastday].first[:day]).to have_key(:uv)
  end
end