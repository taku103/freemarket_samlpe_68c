FactoryBot.define do
    factory :user do
      nickname              { "tanegashiman" }
      email                 { "kkk@gmail.com" }
      password              { "123456a" }
      password_confirmation { "123456a" }
      first_name              { "向井" }
      last_name             { "治" }
      f_first_name        { "ムカイ" }
      f_last_name        { "オサム" }
      birthday_year         { 2018 }
      birthday_month        { 12 }
      birthday_day          { 31 }
    end
  end