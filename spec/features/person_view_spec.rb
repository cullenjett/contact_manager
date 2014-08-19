require 'rails_helper'
require 'capybara/rails'
require 'capybara/rspec'

describe 'the person view', type: :feature do
  let(:alice) do
    Person.create(first_name: "Alice", last_name: "Smith")
  end

  before(:each) do
    alice.phone_numbers.create(number: '555-5555')
    alice.phone_numbers.create(number: '555-1234')
    visit person_path(alice)
  end

  it "shows the phone numbers" do
    alice.phone_numbers.each do |phone|
      expect(page).to have_content(phone.number)
    end
  end

  it "has a link to add a new phone number" do
    expect(page).to have_link('Add phone number', href: new_phone_number_path(person_id: alice.id))
  end

  it "adds a new phone number" do
    click_link('Add phone number')
    fill_in('Number', with: '123-4567')
    click_button('Create Phone number')
    expect(current_path).to eq(person_path(alice))
    expect(page).to have_content('123-4567')
  end
end
