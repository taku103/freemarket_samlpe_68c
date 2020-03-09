require 'rails_helper'

describe User do
  describe '#create' do


    it "is invalid without a nickname" do
      user = build(:user, nickname: "")
      user.valid?
      expect(user.errors[:nickname]).to include("can't be blank")
    end


    it "is invalid without a email" do
      user = build(:user, email: "")
      user.valid?
      expect(user.errors[:email]).to include("can't be blank")
    end

    it "is invalid without a password" do
      user = build(:user, password: "")
      user.valid?
      expect(user.errors[:password]).to include("can't be blank")
    end


    it "is invalid without a password_confirmation" do
      user = build(:user, password_confirmation: "")
      user.valid?
      expect(user.errors[:password_confirmation]).to include("can't be blank")
    end

    it "is invalid without a first_name" do
      user = build(:user, first_name: "")
      user.valid?
      expect(user.errors[:first_name]).to include("can't be blank")
    end


    it "is invalid without a last_name" do
      user = build(:user, last_name: "")
      user.valid?
      expect(user.errors[:last_name]).to include("can't be blank")
    end

    it "is invalid without a f_first_name" do
      user = build(:user, f_first_name: "")
      user.valid?
      expect(user.errors[:f_first_name]).to include("can't be blank")
    end

    it "is invalid without a f_last_name" do
      user = build(:user, f_last_name: "")
      user.valid?
      expect(user.errors[:f_last_name]).to include("can't be blank")
    end

    it "is invalid without a birthday_year" do
      user = build(:user, birthday_year: "")
      user.valid?
      expect(user.errors[:birthday_year]).to include("can't be blank")
    end

    it "is invalid without a birthday_month" do
      user = build(:user, birthday_month: "")
      user.valid?
      expect(user.errors[:birthday_month]).to include("can't be blank")
    end

    it "is invalid without a birthday_day" do
      user = build(:user, birthday_day: "")
      user.valid?
      expect(user.errors[:birthday_day]).to include("can't be blank")
    end


    ## ニックネームが20文字以下なら登録できる

    it "is valid with a nickname that has less than 20 characters " do
        user = build(:user, nickname: "aaaaaaaaaaaaaaaaaaaa") # 20文字
        expect(user).to be_valid
      end
  
    it "is invalid with a nickname that has more than 20 characters" do
        user = build(:user, nickname: "aaaaaaaaaaaaaaaaaaaaa") # 21文字
        user.valid?
        expect(user.errors[:nickname]).to include("is too long (maximum is 20 characters)")
    end
  
  # emailのフォーマットが不適切でないか
  
    it 'is invalid with a email wrong format' do
        user = build(:user, email: '12345678')
        user.valid?
        expect(user.errors[:email]).to include("is invalid")
    end
  
    it 'is invalid with a email wrong format' do
        user = build(:user, email: 'a1234567')
        user.valid?
        expect(user.errors[:email]).to include("is invalid")
    end
  
  # パスワードが7〜128文字であるか
  
    it "is invalid with a password that has less than 6 characters " do
        user = build(:user, password: "a2345", password_confirmation: "a2345")
        user.valid?
        expect(user.errors[:password]).to include("is too short (minimum is 6 characters)")
    end
  
    it "is valid with a password that has more than 7 characters " do
        user = build(:user, password: "a234567", password_confirmation: "a234567")
        user.valid?
        expect(user).to be_valid
    end
  
    it "is valid with a password that has more than 128 characters " do
        user = build(:user, password: "aaaaa12345aaaaa12345aaaaa12345aaaaa12345aaaaa12345aaaaa12345aaaaa12345aaaaa12345aaaaa12345aaaaa12345aaaaa12345aaaaa12345aaaaa123",
        password_confirmation: "aaaaa12345aaaaa12345aaaaa12345aaaaa12345aaaaa12345aaaaa12345aaaaa12345aaaaa12345aaaaa12345aaaaa12345aaaaa12345aaaaa12345aaaaa123") # 128文字
        user.valid?
        expect(user).to be_valid
    end
  
    it "is invalid with a password that has more than 129 characters " do
        user = build(:user, password: "aaaaa12345aaaaa12345aaaaa12345aaaaa12345aaaaa12345aaaaa12345aaaaa12345aaaaa12345aaaaa12345aaaaa12345aaaaa12345aaaaa12345aaaaa1234",
        password_confirmation: "aaaaa12345aaaaa12345aaaaa12345aaaaa12345aaaaa12345aaaaa12345aaaaa12345aaaaa12345aaaaa12345aaaaa12345aaaaa12345aaaaa12345aaaaa1234") # 129文字
        user.valid?
        expect(user.errors[:password][0]).to include("maximum is 128 characters")
    end
  
  # パスワードに英字と数字が含まれているか
  
    it "is valid with a password that Contains letters and numbers " do
        user = build(:user, password: "a234567", password_confirmation: "a234567")
        user.valid?
        expect(user).to be_valid
    end
  
    it "is invalid with a password except for numbers" do
        user = build(:user, password: "1111111111", password_confirmation: "1111111111")
        user.valid?
        expect(user.errors[:password][0]).to include("")
    end
  
    it "is invalid with a password except for alphabets" do
        user = build(:user, password: "aaaaaaa", password_confirmation: "aaaaaaa")
        user.valid?
        expect(user.errors[:password][0]).to include("")
    end
  
  # パスワードに記号を入れても登録できる
  
    it "is valid with a password that Contains letters and numbers and symbol " do
        user = build(:user, password: "a123456!@#$%^&*)(=_-", password_confirmation: "a123456!@#$%^&*)(=_-")
        user.valid?
        expect(user).to be_valid
    end
  
  # パスワードとパスワード（確認）が一致しているか
  
    it "is valid with a password and password confirmation match " do
        user = build(:user, password: "a123456", password_confirmation: "a123456")
        user.valid?
        expect(user).to be_valid
    end
  
    it "is valid with a password and password confirmation match " do
        user = build(:user, password: "a123456", password_confirmation: "b987654")
        user.valid?
        expect(user.errors[:password_confirmation][0]).to include("doesn't match Password")
    end
  
  # 氏名が35文字以下で入力されているか　カナ入力になっているか
  
    it "is valid with a first_name that has less than 35 characters " do
        user = build(:user, first_name: "12345671234567123456712345671234567") # 35文字
        user.valid?
        expect(user).to be_valid
    end
  
    it "is invalid with a first_name that has more than 36 characters " do
        user = build(:user, first_name: "123456712345671234567123456712345671") # 36文字
        user.valid?
        expect(user.errors[:first_name]).to include("is too long (maximum is 35 characters)")
    end
  
    it "is valid with a first_name that has less than 35 characters " do
        user = build(:user, first_name: "12345671234567123456712345671234567")
        user.valid?
        expect(user).to be_valid
    end
  
    it "is invalid with a last_name that has more than 36 characters " do
        user = build(:user, last_name: "123456712345671234567123456712345671")
        user.valid?
        expect(user.errors[:last_name]).to include("is too long (maximum is 35 characters)")
    end
  
    it "is valid with a f_first_name that has less than 35 characters " do
        user = build(:user, first_name: "アアアアアアアアアアアアアアアアアアアアアアアアアアアアアアアアアアア") # 35文字
        user.valid?
        expect(user).to be_valid
    end
  
    it "is invalid with a f_first_name that has more than 36 characters " do
        user = build(:user, f_first_name: "アアアアアアアアアアアアアアアアアアアアアアアアアアアアアアアアアアアア") # 36文字
        user.valid?
        expect(user.errors[:f_first_name]).to include("is too long (maximum is 35 characters)")
    end
  
    it "is valid with a f_last_name that has less than 35 characters " do
        user = build(:user, f_last_name: "アアアアアアアアアアアアアアアアアアアアアアアアアアアアアアアアアアア")
        user.valid?
        expect(user).to be_valid
    end
  
    it "is invalid with a f_last_name that has more than 36 characters " do
        user = build(:user, f_last_name: "アアアアアアアアアアアアアアアアアアアアアアアアアアアアアアアアアアアア")
        user.valid?
        expect(user.errors[:f_last_name]).to include("is too long (maximum is 35 characters)")
    end
  
    it "is valid with a last_name_kana that katakana " do
        user = build(:user, f_first_name: "ア")
        user.valid?
        expect(user).to be_valid
    end
  
    it "is invalid with a last_name_kana that katakana " do
        user = build(:user, f_first_name: "あ")
        user.valid?
        expect(user.errors[:f_first_name][0]).to include("はカタカナで入力して下さい")
    end
  
    it "is valid with a first_name_kana that katakana " do
        user = build(:user, f_last_name: "ア")
        user.valid?
        expect(user).to be_valid
    end
  
    it "is invalid with a first_name_kana that katakana " do
        user = build(:user, f_last_name: "あ")
        user.valid?
        expect(user.errors[:f_last_name][0]).to include("はカタカナで入力して下さい")
    end
  
  end
end