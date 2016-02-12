FactoryGirl.define do
  factory :admin do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password "qwerty123"
    password_confirmation "qwerty123"
  end
end
