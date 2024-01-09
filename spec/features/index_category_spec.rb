require 'rails_helper'

RSpec.feature 'Categories Index Page', type: :feature do
  let(:user) { User.create(name: 'Assem', email: 'assem@example.com', password: 'password123') }
  let!(:category1) { Category.create(author: user, name: 'Groceries', icon: 'https://i.pravatar.cc/300?img=1') }
  let!(:category2) { Category.create(author: user, name: 'Electronics', icon: 'https://i.pravatar.cc/300?img=2') }

  before do
    user.confirm
    sign_in user
    visit categories_path
  end

  scenario 'User visits categories index page' do
    within('.categories-index') do
      expect(page).to have_css('.navbar', text: 'CATEGORIES')
      expect(page).to have_css('.list', count: Category.count)
      expect(page).to have_css('.footer', text: 'ADD CATEGORY')
    end
  end

  scenario 'User clicks on a category' do
    within('.categories-index') do
      click_link category1.name
    end

    expect(page).to have_current_path(category_payments_path(category1))
  end

  scenario 'User clicks on "ADD CATEGORY"' do
    within('.categories-index') do
      click_link 'ADD CATEGORY'
    end

    expect(page).to have_current_path(new_category_path)
  end
end
