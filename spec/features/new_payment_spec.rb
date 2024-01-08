require 'rails_helper'

RSpec.describe 'New Transaction Page', type: :feature do
  let(:user) { User.create(name: 'Assem', email: 'assem@example.com', password: 'password123') }
  let(:category) { Category.create(author_id: user.id, name: 'Food', icon: 'https://i.pravatar.cc/300?img=1') }

  before do
    sign_in user
    visit new_category_payment_path(category)
  end

  context 'User visits new transaction page' do
    it 'shows the heading' do
      expect(page).to have_content('NEW TRANSACTION')
    end

    it 'shows the labels' do
      expect(page).to have_css("input[placeholder='Transaction name']")
      expect(page).to have_css("input[placeholder='0.00']")
      expect(page).to have_css('.checkbox', text: 'Categories')
      expect(page).to have_link('Add a new category', href: new_category_path)
      expect(page).to have_button('ADD', type: 'submit')
    end
  end

  context 'User submits the new transaction form' do
    before(:each) do
      fill_in 'Transaction name', with: 'KFC'
      fill_in '0.00', with: '23'
      check 'Food'
      click_button('ADD')
    end

    it "redirects user to that Category's Transactions list" do
      expect(page).to have_current_path(category_payments_path(category))
    end

    it 'all checked Categories show the newly added Transaction' do
      visit(category_payments_path(category))
      expect(page).to have_content('KFC')
    end

    it 'recalculates the Total Expenses of all checked Groups' do
      visit(category_payments_path(category))
      expect(page).to have_content('$23')
    end
  end

  context 'User submits the new transaction form without filling the form' do
    it 'renders new page again' do
      click_button('ADD')
      expect(page).to have_content('NEW TRANSACTION')
      expect(page).to have_button('ADD', type: 'submit')
    end
  end
end
