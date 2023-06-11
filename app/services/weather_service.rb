require 'faraday'

class WeatherService
  def conn
    Faraday.new(url: "http://api.weatherapi.com/v1/")
  end

  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def get_forecast(params)
    get_url("forecast.json?key=#{ENV['WEATHER_API_KEY']}&q=#{params[:lat]},#{params[:lng]}&days=5")
  end
end