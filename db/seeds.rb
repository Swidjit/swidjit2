# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
category_list = [
  [ "Products", "Buy & sell goods" ],
  [ "Services", "Get help or offer your skills" ],
  [ "Events", "Public happenings around town" ],
  [ "Tidbits", "Interesting or valuable bits of info" ],
  [ "Topics", "Thoughts, ideas and other musings for discussion" ],
  [ "PSA", "Important public safety and health announcements" ],
  [ "Swapper", "Trade your stuff for goods and services" ],
  [ "Freepile", "Give and get free stuff" ],
  [ "Questions", "Ask and answer questions and surveys" ],
  [ "Websites", "Share and discover local websites of interest" ],
  [ "Rentals", "Rent spaces, equipment" ],
  [ "Coupons", "Dispense and claim coupons" ],
  [ "Requests", "Ask, and ye shall receive?" ],
  [ "Meals", "Cook for and dine with others around town" ],
  [ "Playdates", "Find playmates for your kids (and you?)" ],
  [ "Meetups", "Connect in real life with other people" ],
  [ "Rides", "Offer and find rides around the area" ],
  [ "Experiences", "Offer a unique experience for one or more people" ]

]

category_list.each do |name, desc|
  Category.create( name: name, description: desc, category_status: 'active' )
end