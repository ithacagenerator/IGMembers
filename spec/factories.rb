FactoryGirl.define do
  factory :membership_type do
    sequence(:name) { |n| "Member type #{n}" }
    sequence(:monthlycost) { |n| n }
  end

  factory :membership do
    membership_type
    start Date.today()
  end


  factory :member do
    sequence(:lname) { |n| "Person #{n}"}
    sequence(:fname) { |n| "Person #{n}"}
    sequence(:email) { |n| "person_#{n}@example.com"}
    sequence(:address) { |n| "#{n} Test Drive"}
    city "Testberg"
    state "NY"
    zip "11111"
    phone "123-456-7890"
    sequence(:gnucash_id) {|n| "#{n}"}
    memberships {[FactoryGirl.create(:membership)]}
  end

  factory :user do
    sequence(:email) { |n| "person_#{n}@example.com"}
    password "foobar"
    password_confirmation "foobar"
    member

    factory :admin do
      admin true
    end
  end

end
