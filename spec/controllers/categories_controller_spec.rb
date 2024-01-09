require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
  let(:user) { User.create(name: 'Assem', email: 'assem@example.com', password: 'password123') }

  before do   
    user.confirm
    sign_in user
  end

  describe 'GET #index' do
    it 'assigns @categories' do
      get :index
      expect(assigns(:categories)).to eq(user.categories)
    end

    it 'renders the index template' do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe 'GET #new' do
    it 'assigns a new category to @category' do
      get :new
      expect(assigns(:category)).to be_a_new(Category)
    end

    it 'renders the new template' do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'creates a new category' do
        expect {
          post :create, params: { category: { name: 'New Category', icon: 'icon.png' } }
        }.to change(Category, :count).by(1)
      end

      it 'redirects to the categories index page' do
        post :create, params: { category: { name: 'New Category', icon: 'icon.png' } }
        expect(response).to redirect_to(categories_path)
      end
    end

    context 'with invalid attributes' do
      it 'does not create a new category' do
        expect {
          post :create, params: { category: { name: nil, icon: 'icon.png' } }
        }.not_to change(Category, :count)
      end

      it 'renders the new template with unprocessable_entity status' do
        post :create, params: { category: { name: nil, icon: 'icon.png' } }
        expect(response).to render_template(:new)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
