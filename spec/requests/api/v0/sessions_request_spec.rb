require 'rails_helper'

RSpec.describe "Session requests", :vcr do
  describe "create" do
    it "can create a session" do
      user = User.create(email: "test@gmail.com", password: "password", password_confirmation: "password")

      post "/api/v0/sessions", params: {email: "test@gmail.com", password: "password"}

      json = JSON.parse(response.body, symbolize_names: true)
      expect(response).to be_successful
      expect(response.status).to eq(200)
      
      expect(json).to be_a(Hash)
      expect(json).to have_key(:data)
      expect(json[:data]).to be_a(Hash)
      expect(json[:data]).to have_key(:type)
      expect(json[:data][:type]).to be_a(String)
      expect(json[:data]).to have_key(:id)
      expect(json[:data][:id]).to be_a(Integer)
      expect(json[:data]).to have_key(:attributes)
      expect(json[:data][:attributes]).to be_a(Hash)
      expect(json[:data][:attributes]).to have_key(:email)
      expect(json[:data][:attributes][:email]).to be_a(String)
      expect(json[:data][:attributes]).to have_key(:api_key)
    end

    it "can't create a session with an invalid email" do
      user = User.create(email: "test@gmail.com", password: "password", password_confirmation: "password")

      post "/api/v0/sessions", params: {email: "wrong@gmail.com", password: "password"}

      json = JSON.parse(response.body, symbolize_names: true)
      expect(response.status).to eq(400)
      expect(json).to be_a(Hash)
      expect(json).to have_key(:errors)
      expect(json[:errors]).to be_a(Array)
      expect(json[:errors].first).to eq("Invalid email or password")
    end
    
    it "can't create a session with an invalid password" do

      user = User.create(email: "test@gmail.com", password: "password", password_confirmation: "password")
      
      post "/api/v0/sessions", params: {email: "test@gmail.com,", password: "wrong"}

      json = JSON.parse(response.body, symbolize_names: true)
      expect(response.status).to eq(400)
      expect(json).to be_a(Hash)
      expect(json).to have_key(:errors)
      expect(json[:errors]).to be_a(Array)
      expect(json[:errors].first).to eq("Invalid email or password")
    end
  end
end