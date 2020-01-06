FactoryBot.define do

  factory :address do
    user_id                {"1"}
    zipcode                {"100-0001"}
    prefecture_id          {"13"}
    city                   {"千代田区"}
    block                  {"千代田1-1"}
    building               {nil}
    phone                  {nil}
  end

end
