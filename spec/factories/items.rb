FactoryBot.define do

  factory :item do
    name              {'Tシャツ'}
    text              {'こんにちは'}
    condition_id      {1}
    price             {300}
    category_id       {4}
    postage_id        {1}
    prefecture_id     {1}
    shipping_day_id   {1}
    buyer             {2}
    seller            {}
    created_at        { Faker::Time.between(from: DateTime.now - 2, to: DateTime.now) }
    updated_at        { Faker::Time.between(from: DateTime.now - 2, to: DateTime.now) }
  end
end
