# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#
Faker::Config.locale = 'en'
redis_conn = Redis.new(url: "redis://redis:6379/15")
redis_conn.flushall

def range(min, max)
  rand * (max-min) + min
end

# Generate 1000 users
1000.times do
  user_email = Faker::Internet.email
  u = User.create(
      name: Faker::Name.first_name,
      surname: Faker::Name.last_name,
      age: range(20,60).to_i,
      username: user_email.split("@").first,
      email: user_email,
      gender: [true, false].sample
  )
  # Generate coords near Moscow
  long = range 37.218423, 37.918423
  lat = range 55.351244, 55.9
  redis_conn.geoadd(ENV["GEOREDIS_KEY"],lat, long, u.id)
end


