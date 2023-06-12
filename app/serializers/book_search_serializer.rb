class BookSearchSerializer
  def initialize(books,weather)
    @books = books
    @weather = weather
  end

  def serialize
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
            summary: @weather[:current][:condition][:text],
            temperature: "#{@weather[:current][:temp_f]} F"
          },
          total_books_found: @books[:numFound],
          books: @books[:docs].map do |book|
            {
              isbn: book[:isbn],
              title: book[:title],
              publisher: book[:publisher]
            }
          end
        }
      }
    }
  end
end