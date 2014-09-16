require 'rails_helper'

RSpec.describe EmailAddress, :type => :model do
  let(:email_address) do
    EmailAddress.new(address: 'test@example.com', contact_id: 1, contact_type: 'Person')
  end

  it "is valid" do
    expect(email_address).to be_valid
  end

  it "is invalid without an email address" do
    email_address.address = nil
    expect(email_address).not_to be_valid
  end

  it "must have a reference to a person" do
    email_address.contact_id = nil
    expect(email_address).not_to be_valid
  end
end
