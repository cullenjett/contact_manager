require 'rails_helper'

RSpec.describe Person, :type => :model do
  let(:alice) do
    Person.new(first_name: 'Alice', last_name: 'Smith')
  end

  it "is valid" do
    expect(alice).to be_valid
  end

  it "is invalid without a first name" do
    alice.first_name = nil
    expect(alice).not_to be_valid
  end

  it "is invalid without a last name" do
    alice.last_name = nil
    expect(alice).not_to be_valid
  end

  it "responds with its created phone numbers" do
    alice.phone_numbers.build(number: '555-1234')
    expect(alice.phone_numbers.map(&:number)).to eq(['555-1234'])
  end

  it "responds with its created email addresses" do
    alice.email_addresses.build(address: 'alice@example.com')
    expect(alice.email_addresses.map(&:address)).to eq(['alice@example.com'])
  end
end
