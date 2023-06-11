class WeatherFacade
  def initialize(params)
    @params = params
  end

  def forecast
    json = service.get_forecast(@params)
  end

  private 

  def service
   @_service ||= WeatherService.new
  end
end