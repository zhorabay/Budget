class Category < ApplicationRecord
  has_many :transactions_categories, dependent: :destroy
  has_many :transactions, through: :transactions_categories
  belongs_to :user

  validates :name, presence: true
  validates :icon, presence: true
end
