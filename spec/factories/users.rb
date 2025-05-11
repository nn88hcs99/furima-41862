FactoryBot.define do
  factory :user do
    nickname              { Faker::Lorem.characters(number: rand(1..40)) }
    email                 { Faker::Internet.email }
    password              { Faker::Internet.password(min_length: 6, mix_case: true, special_characters: false) }
    password_confirmation { password }
    family_name           { Faker::Japanese::Name.last_name } # ランダムな日本の姓
    last_name             { Faker::Japanese::Name.first_name } # ランダムな日本の名
    kana_family_name      { Faker::Japanese::Name.last_name.yomi } # ランダムなカナ姓
    kana_last_name        { Faker::Japanese::Name.first_name.yomi } # ランダムなカナ名
    birth_date            { Faker::Date.birthday(min_age: 18, max_age: 100) } # 適切な日付を生成
  end
end