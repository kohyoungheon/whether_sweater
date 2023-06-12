class Api::V0::ForecastController < ApplicationController
  def index
    coords = MapquestFacade.new(params).coords
    json = WeatherFacade.new(coords).forecast
    render json: ForecastSerializer.new(json).serialize
  end
end