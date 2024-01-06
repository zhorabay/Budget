class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :categories, dependent: :destroy, foreign_key: :author_id
  has_many :payments, dependent: :destroy, foreign_key: :author_id

  validates :name, presence: true
end
