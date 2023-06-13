class Api::V0::RoadTripController < ApplicationController
  def create
    user = User.find_by(api_key: params[:api_key])
    if user
      road_trip = MapquestFacade.new(params).road_trip

      if road_trip[:info][:statuscode] != 402
        travel_time = road_trip[:route][:formattedTime]
        
        coords = MapquestFacade.new(params[:destination]).coords
        
        forecast = WeatherFacade.new(coords).specific_forecast(travel_time)

        render json: RoadTripSerializer.new(road_trip, forecast).serialize
      else
        render json: RoadTripSerializer.new(road_trip,nil,params).error
      end

    else
      render json: { error: 'Unauthorized API Key' }, status: :unauthorized
    end
  end
end