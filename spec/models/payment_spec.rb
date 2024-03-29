require 'rails_helper'

RSpec.describe Payment, type: :model do
  let(:user) { User.create(name: 'Assem', email: 'assem@example.com', password: 'password123') }
  let(:category) { Category.create(author_id: user.id, name: 'Food', icon: 'https://upload.wikimedia.org/wikipedia/commons/thumb/6/6d/Good_Food_Display_-_NCI_Visuals_Online.jpg/800px-Good_Food_Display_-_NCI_Visuals_Online.jpg') }
  let(:payment) { Payment.create(author_id: user.id, category_ids: [category.id], name: 'KFC', amount: '23') }

  describe 'validations' do
    it 'is not valid without a name' do
      payment.name = nil
      expect(payment).not_to be_valid
    end

    it 'is not valid without an amount' do
      payment.amount = nil
      expect(payment).not_to be_valid
    end

    it 'is not valid with a negative amount' do
      payment.amount = -10
      expect(payment).not_to be_valid
    end

    it 'is valid with a zero amount' do
      payment.amount = 0
      expect(payment).to be_valid
    end

    it 'is valid with a positive amount' do
      payment.amount = 50
      expect(payment).to be_valid
    end
  end
end
