FactoryGirl.define do
  factory :membership_type do
    sequence(:name) { |n| "Member type #{n}" }
    sequence(:monthlycost) { |n| n }
  end

  factory :user do
    sequence(:name) { |n| "Person #{n}"}
    sequence(:email) { |n| "person_#{n}@example.com"}
    sequence(:street) { |n| "#{n} Test Drive"}
    city "Testberg"
    state "NY"
    zip "11111"

    membership_type
    membership_date Date.today()

    password "foobar"
    password_confirmation "foobar"

    factory :admin do
      admin true
    end    
  end
end
