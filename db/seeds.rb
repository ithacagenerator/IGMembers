# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

MembershipType.create([
    { name: 'Basic',      monthlycost:20 },
    { name: 'Standard',   monthlycost:35 },
    { name: 'Extra',      monthlycost:75 },
    { name: 'Benefactor', monthlycost:100 },
  ])

Discount.create([
    { name: 'Student', percent: 25},
    { name: 'Family1', percent: 50},
  ])

ChecklistItem.create([
                         { name: 'Entered into database'},
                         { name: 'Entered into GnuCash'},
                         { name: 'Sent Welcome Email'},
                         { name: 'Added to Google Group'},
                         { name: 'Added to Newsletter'},
                         { name: 'Received first payment'},
                         { name: 'Verified form completed'},
                         { name: 'Notified communities of interest'},
                     ])
