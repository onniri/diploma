# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
1000.times do
  u = User.new :first_name => Faker::Name.first_name,
               :last_name => Faker::Name.last_name
  5.times do
    User.create! :first_name => u.first_name,
                 :last_name => u.last_name,
                 :email => Faker::Internet.email,
                 :password => '123',:password_confirmation => '123',
                 :email_public => true
  end
end