require 'rails_helper'

RSpec.describe Company, :type => :model do
  let(:company) do
    Company.create(name: 'Acme Corp')
  end

  it "is valid" do
    expect(company).to be_valid
  end

  it "is invalid without a name" do
    company.name = nil
    expect(company).not_to be_valid
  end

  it "responds with its phone numbers after they're created" do
    phone_number = company.phone_numbers.build(number: '555-1234')
    expect(phone_number.number).to eq('555-1234')
  end
end