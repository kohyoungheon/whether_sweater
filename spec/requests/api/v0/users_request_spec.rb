require 'rails_helper'

RSpec.describe "User requests" do
  describe "create" do
    it "can create a user" do
      post "/api/v0/users", params: {email: "test@gmail.com", password: "password", password_confirmation: "password"}
      expect(response).to be_successful
      expect(response.status).to eq(201)

      json = JSON.parse(response.body, symbolize_names: true)
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
      expect(json[:data][:attributes][:api_key]).to be_a(String)

      expect(json[:data][:attributes]).to_not have_key(:password)
      expect(json[:data][:attributes]).to_not have_key(:password_confirmation)
      expect(json[:data][:attributes]).to_not have_key(:password_digest)
    end
    it "can't create a user with a duplicate email" do
      user = User.create(email: "test@gmail.com", password: "password", password_confirmation: "password")
      post "/api/v0/users", params: {email: "test@gmail.com", password: "password", password_confirmation: "password"}

      json = JSON.parse(response.body, symbolize_names: true)
      expect(response.status).to eq(400)
      expect(json).to be_a(Hash)
      expect(json).to have_key(:errors)
      expect(json[:errors]).to be_a(Array)
      expect(json[:errors].first).to eq("Email has already been taken")
    end
    it "can't create a user with a password that doesn't match password_confirmation" do
      post "/api/v0/users", params: {email: "test1@gmail.com", password: "password", password_confirmation: "password1"}
      json = JSON.parse(response.body, symbolize_names: true)
      expect(response.status).to eq(400)
      expect(json).to be_a(Hash)
      expect(json).to have_key(:errors)
      expect(json[:errors]).to be_a(Array)
      expect(json[:errors].first).to eq("Password confirmation doesn't match Password")
    end
  end
end