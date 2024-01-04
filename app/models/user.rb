class User < ApplicationRecord
  has_many :categories, dependent: :destroy
  has_many :transactions, through: :categories, source: :transactions

  validates :name, presence: true
end
