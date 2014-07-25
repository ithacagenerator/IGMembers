FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "Person #{n}"}
    sequence(:email) { |n| "person_#{n}@example.com"}
    sequence(:street) { |n| "#{n} Test Drive"}
    city "Testberg"
    state "NY"
    zip "11111"
    password "foobar"
    password_confirmation "foobar"

    factory :admin do
      admin true
    end    
  end
end
