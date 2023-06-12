require 'faraday'

class LibraryService
  def conn
    Faraday.new(url: "https://openlibrary.org/")
  end

  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def get_books(search_term)
    require 'pry'; binding.pry
    get_url("search.json?q=#{}+#{}")
  end
end