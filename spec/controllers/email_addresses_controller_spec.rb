require 'rails_helper'

RSpec.describe EmailAddressesController, :type => :controller do
  describe "POST create" do
    it "redirects to the email address' person show page" do
      alice = Person.create(first_name: 'Alice', last_name: 'Smith')
      valid_attributes = { address: 'alice@example.com', person_id: alice.id}
      post :create, {:email_address => valid_attributes}
      expect(response).to redirect_to alice
    end
  end

  describe "PUT update" do
    it "redirects to the email address' person show page" do
      alice = Person.create(first_name: 'Alice', last_name: 'Smith')
      valid_attributes = { address: 'alice@example.com', person_id: alice.id}
      email_address = EmailAddress.create!(valid_attributes)
      put :update, {:id => email_address.to_param, :email_address => valid_attributes}
      expect(response).to redirect_to alice
    end
  end

  describe "DELETE destroy" do
    it "deltes the email address" do
      alice = Person.create(first_name: 'Alice', last_name: 'Smith')
      email_address = alice.email_addresses.create!(address: 'test@example.com')
      delete :destroy, { id: email_address.to_param }
      expect(alice.email_addresses.count).to eq(0)
    end

    it "redirects to the email address' person page" do
      alice = Person.create(first_name: 'Alice', last_name: 'Smith')
      email_address = alice.email_addresses.create!(address: 'test@example.com')
      delete :destroy, { id: email_address.to_param }
      expect(response).to redirect_to alice
    end
  end
end
