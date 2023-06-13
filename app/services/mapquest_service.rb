require 'faraday'

class MapquestService
  
  def get_coords(params)
    get_url("geocoding/v1/address?key=#{ENV['MAPQUEST_API_KEY']}&location=#{params}")
  end

  def get_road_trip(params)
    get_url("directions/v2/route?key=#{ENV['MAPQUEST_API_KEY']}&from=#{params[:origin]}&to=#{params[:destination]}")
  end

    private
    def conn
      Faraday.new(url: "https://www.mapquestapi.com/")
    end
  
    def get_url(url)
      response = conn.get(url)
      JSON.parse(response.body, symbolize_names: true)
    end
end