FactoryBot.define do
  factory :user do
    email                    { Faker::Internet.free_email }
    password = "abcd1234"
    password                 { password } 
    password_confirmation    { password }
    nickname              { Faker::Name.name }
    last_name             { "山田" }
    first_name            { "太郎" }
    last_name_kana        { "ヤマダ" }
    first_name_kana       { "タロウ" }
    birth_date            { Faker::Date.birthday }
  end
end