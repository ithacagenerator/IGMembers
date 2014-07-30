namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    admin = User.create!(name: "Example User",
      email: "admin@example.com",
      street: Faker::Address.street_address,
      city: Faker::Address.city,
      state: Faker::Address.state_abbr,
      zip: Faker::Address.zip,
      password: "foobar",
      password_confirmation: "foobar",
      membership_type: MembershipType.find_by_name("Extra"),
      membership_date:  Date.today(),
      admin: true)
    basic = MembershipType.find_by_name("Basic")
    99.times do |n|
      name = Faker::Name.name
      email = "example-#{n+1}@railstutorial.org"
      password = "password"
      User.create!(name: name,
        email: email,
        street: Faker::Address.street_address,
        city: Faker::Address.city,
        state: Faker::Address.state_abbr,
        zip: Faker::Address.zip,
        password: password,
        password_confirmation: password,
        membership_type: basic,
        membership_date:  Date.today())
    end
  end
end

    
