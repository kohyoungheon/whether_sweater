require 'faraday'

class MapquestService
  def conn
    Faraday.new(url: "https://www.mapquestapi.com/geocoding/")
  end

  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def get_coords(params)
    get_url("v1/address?key=#{ENV['MAPQUEST_API_KEY']}&location=#{params[:location]}")
  end
end