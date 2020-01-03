FactoryBot.define do

  factory :user do
    nickname              {Faker::Name.name}
    email                 {Faker::Internet.email}
    password              {"123456a"}
    last_name             {"山田"}
    first_name            {"彩"}
    last_name_kana        {"ヤマダ"}
    first_name_kana       {"アヤ"}
    birthday              {"2000-01-01"}
    phone_authy           {"09012345678"}
  end

end