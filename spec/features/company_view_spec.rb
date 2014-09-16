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

  describe 'email addresses' do
    before do
      company.email_addresses.create(address: 'company@example.com')
      company.email_addresses.create(address: 'acme@example.com')
      visit company_path(company)
    end

    it "shows the email addresses" do
      expect(page).to have_selector('li', text: 'company@example.com')
      expect(page).to have_selector('li', text: 'acme@example.com')
    end

    it "has an add email address link" do
      expect(page).to have_link('Add email address', href: new_email_address_path(contact_id: company.id, contact_type: 'Company'))
    end

    it "adds a new email address" do
      click_link('Add email address')
      fill_in('Address', with: 'test@example.com')
      click_button('Create Email address')
      expect(current_path).to eq(company_path(company))
      expect(page).to have_content('test@example.com')
    end

    it "has links to edit email addresses" do
      company.email_addresses.each do |email_address|
        expect(page).to have_link('edit', href: edit_email_address_path(email_address))
      end
    end

    it "edits email addresses" do
      email = company.email_addresses.first
      old_email = email.address

      within('.email_addresses') do
        first(:link, 'edit').click
      end
      fill_in 'Address', with: 'newemail@example.com'
      click_button 'Update Email address'
      expect(current_path).to eq(company_path(company))
      expect(page).to have_content('newemail@example.com')
      expect(page).not_to have_content(old_email)
    end

    it "has links to delete email addresses" do
      company.email_addresses.each do |email_address|
        expect(page).to have_link('delete')
      end
    end

    it "deletes an email address" do
      email = company.email_addresses.first
      old_email = email.address

      within('.email_addresses') do
        first(:link, 'delete').click
      end
      expect(current_path).to eq(company_path(company))
      expect(page).not_to have_content(old_email)
    end
  end
end
