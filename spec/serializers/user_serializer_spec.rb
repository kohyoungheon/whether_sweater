require 'rails_helper'

RSpec.describe UserSerializer, type: :serializer do
  it 'can serialize users' do
    user = User.create(email: 'what@gmail.com', password: 'password', password_confirmation: 'password', api_key: "12345")
    serialized = UserSerializer.new(user).serialize
    
    expect(serialized).to be_a(Hash)
    expect(serialized).to have_key(:data)
    expect(serialized[:data]).to be_a(Hash)
    expect(serialized[:data]).to have_key(:type)
    expect(serialized[:data][:type]).to be_a(String)
    expect(serialized[:data]).to have_key(:id)
    expect(serialized[:data][:id]).to be_a(Integer)
    expect(serialized[:data]).to have_key(:attributes)
    expect(serialized[:data][:attributes]).to be_a(Hash)
    expect(serialized[:data][:attributes]).to have_key(:email)
    expect(serialized[:data][:attributes][:email]).to be_a(String)
    expect(serialized[:data][:attributes]).to have_key(:api_key)
    expect(serialized[:data][:attributes][:api_key]).to be_a(String)
    

    expect(serialized[:data][:attributes]).to_not have_key(:password)
    expect(serialized[:data][:attributes]).to_not have_key(:password_confirmation)
    expect(serialized[:data][:attributes]).to_not have_key(:password_digest)
  end
end