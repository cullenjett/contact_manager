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
end
