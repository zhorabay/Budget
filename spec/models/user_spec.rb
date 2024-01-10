require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { User.create(name: 'Assem', email: 'assem@example.com', password: 'password123') }

  before { subject.save }

  describe '#validations' do
    it 'is not valid without a name' do
      subject.name = nil
      expect(subject).to_not be_valid
    end
  end
end
