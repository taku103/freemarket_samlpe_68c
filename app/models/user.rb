class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :validatable

  VALID_EMAIL_REGEX =  /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  VALID_KATAKANA_REGEX = /\A[\p{katakana}\p{blank}ー－]+\z/
  VALID_PASSWORD_REGEX = /\A(?=.*?[a-zA-Z])(?=.*?\d)[a-zA-Z\d!@#\$%\^\&*\)\(+=._-]{7,128}\z/i

  # step1入力項目

  validates :nickname,       presence: true, length: {maximum: 20}
  validates :email,          presence: true, uniqueness: true, format: { with: VALID_EMAIL_REGEX }
  validates :password,       presence: true, length: {minimum: 7, maximum: 128}, format: { with: VALID_PASSWORD_REGEX, message: 'は英字と数字両方を含むパスワードを設定してください'}
  validates :password_confirmation, presence: true, length: {minimum: 7, maximum: 128}, format: { with: VALID_PASSWORD_REGEX, message: 'は英字と数字両方を含むパスワードを設定してください'}
  validates :first_name,     presence: true, length: { maximum: 35 }
  validates :last_name,      presence: true, length: { maximum: 35 }
  validates :f_first_name,   presence: true, length: { maximum: 35 }, format: { with: VALID_KATAKANA_REGEX, message: 'はカタカナで入力して下さい'}
  validates :f_last_name,    presence: true, length: { maximum: 35 }, format: { with: VALID_KATAKANA_REGEX, message: 'はカタカナで入力して下さい'}

  has_many :cards
  has_one :address
  accepts_nested_attributes_for :address

         :recoverable, :rememberable, :validatable

end
