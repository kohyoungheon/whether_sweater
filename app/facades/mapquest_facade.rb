class MapquestFacade
  def initialize(params)
    @params = params
  end

  def coords
    json = service.get_coords(@params)
    json = json[:results][0][:locations][0][:latLng]
  end

  def road_trip
    json = service.get_road_trip(@params)
  end

  private 

  def service
   @_service ||= MapquestService.new
  end
end