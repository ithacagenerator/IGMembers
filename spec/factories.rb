FactoryGirl.define do
  factory :user do
    name     "Blaise Pascal"
    email    "blaisepascal@gmail.com"
    password "foobar"
    password_confirmation "foobar"
  end
end
