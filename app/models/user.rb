class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :validatable

  has_many :categories, dependent: :destroy, foreign_key: :author_id
  has_many :payments, dependent: :destroy, foreign_key: :author_id

  validates :name, presence: true
end
