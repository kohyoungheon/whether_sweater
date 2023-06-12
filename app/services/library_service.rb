require 'faraday'

class LibraryService
  def conn
    Faraday.new(url: "https://openlibrary.org/")
  end

  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def get_books(search_term,limit)
    get_url("search.json?q=#{search_term.split(",")[0]}+#{search_term.split(",")[1]}&limit=#{limit}")
  end
end