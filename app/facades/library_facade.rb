class LibraryFacade
  def initialize(params)
    @params = params
  end

  def books
    json = service.get_books(@params)
  end

  private 

  def service
   @_service ||= LibraryService.new
  end
end