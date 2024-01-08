require 'rails_helper'

RSpec.describe PaymentsController, type: :controller do
  let(:user) { User.create(name: 'Assem', email: 'assem@example.com', password: 'password123') }
  let(:category) { Category.create(author_id: user.id, name: 'Food', icon: 'https://upload.wikimedia.org/wikipedia/commons/thumb/6/6d/Good_Food_Display_-_NCI_Visuals_Online.jpg/800px-Good_Food_Display_-_NCI_Visuals_Online.jpg') }
  let(:payment) { Payment.create(author_id: user.id, category_ids: [category.id], name: 'KFC', amount: '23') }

  before { sign_in user }

  describe 'GET #index' do
    context 'with valid category_id' do
      it 'assigns @category' do
        get :index, params: { category_id: category.id }
        expect(assigns(:category)).to eq(category)
      end

      it 'assigns @categories' do
        get :index, params: { category_id: category.id }
        expect(assigns(:categories)).to eq([category])
      end

      it 'assigns @payments' do
        get :index, params: { category_id: category.id }
        expect(assigns(:payments)).to eq([payment])
      end

      it 'renders the index template' do
        get :index, params: { category_id: category.id }
        expect(response).to render_template(:index)
      end
    end

    context 'with invalid category_id' do
      it 'sets flash error and redirects to categories_path' do
        get :index, params: { category_id: 'invalid_id' }
        expect(flash[:error]).to eq('Category not found')
        expect(response).to redirect_to(categories_path)
      end
    end
  end

  describe 'GET #new' do
    it 'assigns @category' do
      get :new, params: { category_id: category.id }
      expect(assigns(:category)).to eq(category)
    end

    it 'assigns a new payment to @payment' do
      get :new, params: { category_id: category.id }
      expect(assigns(:payment)).to be_a_new(Payment)
    end

    it 'renders the new template' do
      get :new, params: { category_id: category.id }
      expect(response).to render_template(:new)
    end
  end

  describe 'POST #create' do
    it 'creates a new payment' do
      expect(post(:create, params: { category_id: category.id, payment: { name: 'KFC', amount: '23', category_ids: [category.id] } })).to change(Payment, :count).by(1)
    end

    it 'redirects to category_payments_path' do
      post :create, params: { category_id: category.id, payment: { name: 'KFC', amount: '23', category_ids: [category.id] } }
      expect(response).to redirect_to(category_payments_path(category.id))
    end

    context 'with invalid attributes' do
      it 'does not create a new payment' do
        expect(post(:create, params: { category_id: category.id, payment: { name: nil, amount: '23', category_ids: [category.id] } })).not_to change(Payment, :count)
      end
    end
  end
end
