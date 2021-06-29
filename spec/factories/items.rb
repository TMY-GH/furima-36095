FactoryBot.define do
  factory :item do
    name { '商品①' }
    info { 'テストテストテストテストです。' }
    category_id { 2 }
    status_id { 2 }
    shipping_fee_id { 2 }
    prefecture_id { 2 }
    delivery_days_id { 2 }
    price { 300 }
    association :user

    after(:build) do |post|
      post.image.attach(io: File.open('public/images/sample.png'), filename: 'sample.png', content_type: 'image/png')
    end
  end
end
