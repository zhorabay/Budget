require 'rails_helper'

RSpec.feature 'New Category Page', type: :feature do
  let(:user) { User.create(name: 'Assem', email: 'assem@example.com', password: 'password123') }

  before do
    sign_in user
    visit new_category_path
  end

  scenario 'User visits new category page' do
    within('.categories-new') do
      expect(page).to have_css('.navbar', text: 'NEW CATEGORY')
      expect(page).to have_field('category_name', type: 'text', placeholder: 'Category name')
      expect(page).to have_field('category_icon', type: 'text', placeholder: 'Icon link: https://i.pravatar.cc/300?img=5')
      expect(page).to have_css('.warn', text: '* Please, provide a valid link that starts with')
      expect(page).to have_button('ADD', type: 'submit')
    end
  end

  scenario 'User submits the new category form' do
    within('.categories-new') do
      fill_in 'category_name', with: 'Groceries'
      fill_in 'category_icon', with: 'https://i.pravatar.cc/300?img=5'
      click_button 'ADD'
    end

    expect(page).to have_current_path(categories_path)
  end
end
