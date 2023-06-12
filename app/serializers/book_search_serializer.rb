class BookSearchSerializer
  def initialize(books,weather)
    @books = books
    @weather = weather
  end

  def serialize
    require 'pry'; binding.pry
    {
      data: 
      {
        id: nil,
        type: "books",
        attributes:
        {
          destination: @books[:docs][0][:title],
          forecast:
          {
            summary: @weather[:current][:weather][:condition][:text],
          }
        }
      }
    }
  end
end