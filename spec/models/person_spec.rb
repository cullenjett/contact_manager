require 'rails_helper'

RSpec.describe Person, :type => :model do
  it "is valid" do
    alice = Person.new(first_name: 'Alice', last_name: 'Smith')
    expect(alice).to be_valid
  end

  it "is invalid without a first name" do
    alice = Person.new(first_name: nil)
    expect(alice).not_to be_valid
  end

  it "is invalid without a last name" do
    alice = Person.new(last_name: nil)
    expect(alice).not_to be_valid
  end
end
