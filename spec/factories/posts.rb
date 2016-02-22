FactoryGirl.define do
  factory :post do
    title { Faker::Name.title }
    body { Faker::Lorem.paragraph }
    disabled false
    
    factory :unpublished_post do
      disabled true
    end
  end
end
