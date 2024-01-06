class Payment < ApplicationRecord
  has_many :category_payments
  has_many :categories, through: :category_payments

  belongs_to :author, class_name: 'User', foreign_key: 'author_id'

  validates :name, presence: true
  validates :amount, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
