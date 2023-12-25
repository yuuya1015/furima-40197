class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable

      validates :nickname,        presence: true
      validates :first_name,      presence: true
      validates :first_name_ruby, presence: true
      validates :last_name,       presence: true
      validates :last_name_ruby,  presence: true
      validates :date,            presence: true

      has_many :items
      has_many :payments
    end