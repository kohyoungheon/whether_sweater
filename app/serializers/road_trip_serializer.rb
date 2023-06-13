class RoadTripSerializer
  def initialize(road_trip, forecast = nil, params = nil)
    @road_trip = road_trip
    @forecast = forecast
    @params = params
  end

  def serialize
    {
      data:
      {
        id: nil,
        type: "road_trip",
        attributes:
        {
          start_city: "#{@road_trip[:route][:locations][0][:adminArea5]}, #{@road_trip[:route][:locations][0][:adminArea3]}",
          end_city: "#{@road_trip[:route][:locations][1][:adminArea5]}, #{@road_trip[:route][:locations][1][:adminArea3]}",
          travel_time: @road_trip[:route][:formattedTime],
          weather_at_eta: 
          {
            datetime: @forecast[:forecast][:forecastday][0][:hour][0][:time],
            temperature: @forecast[:forecast][:forecastday][0][:hour][0][:temp_f],
            conditions: @forecast[:forecast][:forecastday][0][:hour][0][:condition][:text]
          }
        }
      }
    }
  end

  def error
    {
      data:
      {
        id: nil,
        type: "road_trip",
        attributes:
        {
          start_city: "#{@params[:origin]}",
          end_city: "#{@params[:destination]}",
          travel_time: "impossible",
          weather_at_eta:
          {

          }
        }
      }
    }
  end
end