require 'rails_helper'

RSpec.feature 'Transactions Page', type: :feature do
  let(:user) { User.create(name: 'Assem', email: 'assem@example.com', password: 'password123') }
  let(:category) { Category.create(author: user, name: 'Groceries', icon: 'https://i.pravatar.cc/300?img=1') }
  let!(:payment1) { Payment.create(author: user, category_ids: [category.id], name: 'Grocery shopping', amount: 50) }
  let!(:payment2) { Payment.create(author: user, category_ids: [category.id], name: 'Electronics', amount: 100) }

  before do
    sign_in user
    visit category_payments_path(category)
  end

  scenario 'User visits transactions page' do
    within('.categories-index') do
      expect(page).to have_css('.navbar', text: 'TRANSACTIONS')
      expect(page).to have_css('.amount', text: "Total amount: $#{category.payments.sum(:amount)}")
      expect(page).to have_css('.list', count: Payment.count)
      expect(page).to have_css('.footer', text: 'ADD PAYMENT')
    end
  end

  scenario 'User clicks on "ADD PAYMENT"' do
    within('.categories-index') do
      click_link 'ADD PAYMENT'
    end

    expect(page).to have_current_path(new_category_payment_path(category))
  end
end
