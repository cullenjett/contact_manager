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

  it "has links to edit phone numbers" do
    alice.phone_numbers.each do |phone|
      expect(page).to have_link('edit', href: edit_phone_number_path(phone))
    end
  end

  it "edits a phone number" do
    phone = alice.phone_numbers.first
    old_number =  phone.number

    first(:link, 'edit').click
    fill_in 'Number', with: '555-9911'
    click_button 'Update Phone number'
    expect(current_path).to eq(person_path(alice))
    expect(page).to have_content('555-9911')
    expect(page).not_to have_content(old_number)
  end

  it "has a link to delete each phone number" do
    expect(page).to have_link('delete')
  end

  it "deletes a phone number" do
    phone = alice.phone_numbers.first
    old_number = phone.number

    first(:link, 'delete').click
    expect(current_path).to eq(person_path(alice))
    expect(page).to have_content(alice.first_name)
    expect(page).not_to have_content(old_number)
  end
end
