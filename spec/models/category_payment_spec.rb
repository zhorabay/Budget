require 'rails_helper'

RSpec.describe CategoryPayment, type: :model do
  let(:user) { User.create(name: 'Assem', email: 'assem@example.com', password: 'password123') }
  let(:category) { Category.create(author_id: user.id, name: 'Food', icon: 'https://upload.wikimedia.org/wikipedia/commons/thumb/6/6d/Good_Food_Display_-_NCI_Visuals_Online.jpg/800px-Good_Food_Display_-_NCI_Visuals_Online.jpg') }
  let(:payment) { Payment.create(author_id: user.id, category_ids: [category.id], name: 'KFC', amount: '23')}
  let(:category_payment) { CategoryPayment.create(payment_id: payment.id, category_id: category.id) }

  describe 'associations' do
    it 'belongs to a payment' do
      expect(category_payment.payment).to eq(payment)
    end

    it 'belongs to a category' do
      expect(category_payment.category).to eq(category)
    end
  end
end
