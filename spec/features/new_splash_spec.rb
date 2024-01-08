require 'rails_helper'

RSpec.describe 'Splash New', type: :feature do
  before(:each) do
    visit unauthenticated_root_path
  end

  context 'it shows the correct' do
    it 'shows the heading' do
      expect(page).to have_content('Wealth Wave')
    end

    it 'shows the links' do
      expect(page).to have_link('LOG IN', href: new_user_session_path)
      expect(page).to have_link('SIGN UP', href: new_user_registration_path)
    end
  end

  context 'When user clicks on links' do
    it 'redirects me to sign in pages' do
      click_on('LOG IN')
      expect(page).to have_current_path(new_user_session_path)
    end

    it 'redirects me to sign up page' do
      click_on('SIGN UP')
      expect(page).to have_current_path(new_user_registration_path)
    end
  end

  context 'When user logs in with valid attributes' do
    let(:user) { User.create(name: 'Assem', email: 'assem@example.com', password: 'password123') }

    before(:each) do
      sign_in user
      visit new_user_session_path
    end

    it 'redirects me to categories page' do
      expect(page).to have_current_path(authenticated_root_path)
    end
  end

  def sign_up(user)
    fill_in 'Name', with: user.name
    fill_in 'Email', with: user.email
    fill_in 'user_password', with: user.password
    fill_in 'user_password_confirmation', with: user.password
    click_on('Next')
  end
end
