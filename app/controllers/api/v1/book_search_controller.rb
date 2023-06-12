class Api::V1::BookSearchController < ApplicationController
  def index
    if params[:location].present? && params[:quantity].present?
      coords = MapquestFacade.new(params).coords
      books = LibraryFacade.new(params).books
      weather = WeatherFacade.new(coords).forecast
      render json: BookSearchSerializer.new(books, weather).serialize
    else
      render json: { errors: "Please provide a location and quantity" }, status: 400
    end
  end
end