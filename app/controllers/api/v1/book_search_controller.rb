class Api::V1::BookSearchController < ApplicationController
  def index
    if params[:location].present? && params[:quantity].present?
      books = LibraryFacade.new(params[:location]).books
    else
      render json: { errors: "Please provide a location and quantity" }, status: 400
    end
  end
end