# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

MembershipType.create([
    { name: "Basic",      monthlycost:20 },
    { name: "Standard",   monthlycost:35 },
    { name: "Extra",      monthlycost:75 },
    { name: "Benefactor", monthlycost:100 },
  ])
