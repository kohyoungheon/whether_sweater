require 'rails_helper'

RSpec.describe "User requests" do
  describe "create" do
    it "can create a user"
    it "can't create a user with a duplicate email"
    it "can't create a user with a password that doesn't match password_confirmation"
  end
end