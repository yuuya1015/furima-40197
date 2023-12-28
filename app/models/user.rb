class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable

      validates :nickname,        presence: true
      validates :first_name,      presence: true
      validates :first_name_ruby, presence: true
      validates :last_name,       presence: true
      validates :last_name_ruby,  presence: true
      validates :birthday,        presence: true

      PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i.freeze
      validates_format_of :password, with: PASSWORD_REGEX, message: 'には英字と数字の両方を含めて設定してください' 

      with_options presence: true, format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: '全角文字を使用してください' } do
        validates :first_name
        validates :last_name
      end
      

      #has_many :items
      #has_many :payments

      user = User.new
      user.valid?

    end