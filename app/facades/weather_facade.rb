class WeatherFacade
  def initialize(params)
    @params = params
  end

  def forecast
    json = service.get_forecast(@params)
  end

  def specific_forecast(travel_time)
    json = service.get_specific_forecast(@params, travel_time)
  end

  private 

  def service
   @_service ||= WeatherService.new
  end
end