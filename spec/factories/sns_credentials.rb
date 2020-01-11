FactoryBot.define do
  factory :sns_credential do
    provider          { "MyString" }
    uid               { "MyString" }
    user_id           { nil }
  end
end