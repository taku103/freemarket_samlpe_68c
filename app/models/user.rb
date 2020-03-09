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
  validates :birthday_year,  presence: true
  validates :birthday_month, presence: true
  validates :birthday_day,   presence: true
  has_many :cards
  has_one :address
  accepts_nested_attributes_for :address

  # item-Exhibition-function入力項目

  has_many :bought_items, foreign_key: "buyer_id", class_name: "Item"
  has_many :selling_items, -> { where("buyer_id is NULL") }, foreign_key: "seller_id", class_name: "Item"
  has_many :sold_items, -> { where("buyer_id is not NULL") }, foreign_key: "seller_id", class_name: "Item"

end
