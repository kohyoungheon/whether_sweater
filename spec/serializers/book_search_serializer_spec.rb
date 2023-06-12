require 'rails_helper'

RSpec.describe BookSearchSerializer, type: :serializer do
  it 'can serialize books and weather' do
    json1 = File.read('spec/fixtures/forecast.json')
    weather = JSON.parse(json1, symbolize_names: true)

    json2 = File.read('spec/fixtures/books.json')
    books = JSON.parse(json2, symbolize_names: true)

    serialized = BookSearchSerializer.new(books,weather).serialize
    expect(serialized).to be_a(Hash)
    expect(serialized).to have_key(:data)
    expect(serialized[:data]).to be_a(Hash)
    expect(serialized[:data]).to have_key(:id)
    expect(serialized[:data][:id]).to eq(nil)
    expect(serialized[:data]).to have_key(:type)
    expect(serialized[:data][:type]).to eq('books')
    expect(serialized[:data]).to have_key(:attributes)
    expect(serialized[:data][:attributes]).to be_a(Hash)
    expect(serialized[:data][:attributes]).to have_key(:destination)
    expect(serialized[:data][:attributes][:destination]).to be_a(String)
    expect(serialized[:data][:attributes]).to have_key(:forecast)
    expect(serialized[:data][:attributes][:forecast]).to be_a(Hash)
    expect(serialized[:data][:attributes][:forecast]).to have_key(:summary)
    expect(serialized[:data][:attributes][:forecast][:summary]).to be_a(String)
    expect(serialized[:data][:attributes][:forecast]).to have_key(:temperature)
    expect(serialized[:data][:attributes][:forecast][:temperature]).to be_a(String)

    expect(serialized[:data][:attributes]).to have_key(:total_books_found)
    expect(serialized[:data][:attributes][:total_books_found]).to be_a(Integer)
    expect(serialized[:data][:attributes]).to have_key(:books)
    expect(serialized[:data][:attributes][:books]).to be_a(Array)
    expect(serialized[:data][:attributes][:books].count).to eq(5)
    expect(serialized[:data][:attributes][:books][0]).to be_a(Hash)
    expect(serialized[:data][:attributes][:books][0]).to have_key(:isbn)
    expect(serialized[:data][:attributes][:books][0][:isbn]).to be_a(Array)
    expect(serialized[:data][:attributes][:books][0]).to have_key(:title)
    expect(serialized[:data][:attributes][:books][0][:title]).to be_a(String)
    expect(serialized[:data][:attributes][:books][0]).to have_key(:publisher)
    expect(serialized[:data][:attributes][:books][0][:publisher]).to be_a(Array)
  end
end