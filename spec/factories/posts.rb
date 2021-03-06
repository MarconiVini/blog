FactoryGirl.define do
  factory :post do
    title { Faker::Name.title }
    body { Faker::Lorem.paragraph }
    published false
    
    factory :published_post do
      published true
    end
  end
end
