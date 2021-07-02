FactoryBot.define do
  factory :solditem_address do
    association :user_id
    association :item_id
    association :solditem_id
    token           { "token1234567890"}
    post_number     { "123-1234" }
    prefecture_id   { 1 }
    city            { "東京" }
    addresses       { "東京区" }
    building        { "東京タワー" }
    phone_number    { "1234567890" }
  end
end
