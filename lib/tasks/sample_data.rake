namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do

    member = Member.create!(
      lname: "User",
      fname: "Super",
      email: "admin@example.com",
      address: Faker::Address.street_address,
      city: Faker::Address.city,
      state: Faker::Address.state_abbr,
      zip: Faker::Address.zip,
      phone: Faker::PhoneNumber.phone_number,
      gnucash_id: "aardvark"
    )

    admin = User.create!(
      member_id: member.id,
      email: member.email,
      password: "foobar",
      password_confirmation: "foobar",
      admin: true
    )
      
=begin
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
=end
  end
end

    
