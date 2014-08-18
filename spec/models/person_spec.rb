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
end
