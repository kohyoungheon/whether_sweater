require 'faraday'
require 'date'
require 'time'

class WeatherService

  def get_forecast(params)
    get_url("forecast.json?key=#{ENV['WEATHER_API_KEY']}&q=#{params[:lat]},#{params[:lng]}&days=5")
  end

  def get_specific_forecast(params, travel_time)
    travel_hours = travel_time.split(':')[0].to_i
    arrival_time = DateTime.now + (travel_hours / 24.0)
    formatted_date = arrival_time.strftime('%Y-%m-%d')
    formatted_hour = arrival_time.strftime('%H')
    
    get_url("forecast.json?key=#{ENV['WEATHER_API_KEY']}&q=#{params[:lat]},#{params[:lng]}&dt=#{formatted_date}&hour=#{formatted_hour}")
  end

    private
    def conn
      Faraday.new(url: "http://api.weatherapi.com/v1/")
    end
  
    def get_url(url)
      response = conn.get(url)
      JSON.parse(response.body, symbolize_names: true)
    end
end