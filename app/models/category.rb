class Category < ApplicationRecord
  has_many :category_payments
  has_many :payments, through: :category_payments

  belongs_to :author, class_name: 'User', foreign_key: 'author_id'

  validates :name, presence: true
  validates :icon, presence: true
end
