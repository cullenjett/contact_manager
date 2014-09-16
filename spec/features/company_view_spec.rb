require 'rails_helper'
require 'capybara/rails'
require 'capybara/rspec'

describe 'the company view', type: :feature do
  let(:company) do
    Company.create(name: 'Acme Corp')
  end

  describe 'phone numbers' do
    before(:each) do
      company.phone_numbers.create(number: '555-5555')
      company.phone_numbers.create(number: '555-1234')
      visit company_path(company)
    end

    it "shows the phone numbers" do
      company.phone_numbers.each do |phone|
        expect(page).to have_content(phone.number)
      end
    end

    it "has a link to add a new phone number" do
      expect(page).to have_link('Add phone number', href: new_phone_number_path(contact_id: company.id, contact_type: 'Company'))
    end

    it "adds a new phone number" do
      click_link('Add phone number')
      fill_in('Number', with: '123-4567')
      click_button('Create Phone number')
      expect(current_path).to eq(company_path(company))
      expect(page).to have_content('123-4567')
    end

    it "has links to edit phone numbers" do
      company.phone_numbers.each do |phone|
        expect(page).to have_link('edit', href: edit_phone_number_path(phone))
      end
    end

    it "edits a phone number" do
      phone = company.phone_numbers.first
      old_number =  phone.number

      first(:link, 'edit').click
      fill_in 'Number', with: '555-9911'
      click_button 'Update Phone number'
      expect(current_path).to eq(company_path(company))
      expect(page).to have_content('555-9911')
      expect(page).not_to have_content(old_number)
    end

    it "has a link to delete each phone number" do
      expect(page).to have_link('delete')
    end

    it "deletes a phone number" do
      phone = company.phone_numbers.first
      old_number = phone.number

      first(:link, 'delete').click
      expect(current_path).to eq(company_path(company))
      expect(page).to have_content(company.name)
      expect(page).not_to have_content(old_number)
    end
  end
end
