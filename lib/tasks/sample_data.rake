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
      
    basic = MembershipType.find_by_name("Basic")
    19.times do |n|
      fname = Faker::Name.first_name
      lname = Faker::Name.last_name
      email = "example-#{n+1}@railstutorial.org"
      Member.create!(
          fname: fname,
          lname: lname,
          email: email,
          address: Faker::Address.street_address,
          city: Faker::Address.city,
          state: Faker::Address.state_abbr,
          zip: Faker::Address.zip,
          phone: Faker::PhoneNumber.phone_number,
      )
    end
  end
end


    
