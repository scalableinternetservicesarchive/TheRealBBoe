# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.find_or_create_by(name: 'Ryan', username: 'Ryan X.', password: 'password', is_auth: true)
User.find_or_create_by(name: 'April', username: 'aprilsanchez', password: 'password', is_auth: true)
User.find_or_create_by(name: 'Laboni', username: 'Laboni', password: 'password', is_auth: true)
User.find_or_create_by(name: 'Wei-Yee', username: 'weigee', password: 'password', is_auth: true)
User.find_or_create_by(name: 'Saurav', username: 'sauravucsb', password: 'password', is_auth: true)
User.find_or_create_by(name: 'Mat', username: 'mateolithium', password: 'password', is_auth: true)

Location.find_or_create_by(name: "Isla Vista")
Location.find_or_create_by(name: "Santa Barbara")
Location.find_or_create_by(name: "Solvang")

Room.find_or_create_by(token: "ABCDE", name: "Manzanita Floor 1 Decision", location_id: 1)

Member.find_or_create_by(room_id: 1, user_id: 1, is_host: false)
Member.find_or_create_by(room_id: 1, user_id: 2, is_host: false)
Member.find_or_create_by(room_id: 1, user_id: 3, is_host: true)
Member.find_or_create_by(room_id: 2, user_id: 1, is_host: true)


Restaurant.find_or_create_by(name: "Deja Vu", location_id: 1, description: "Indian food")
Restaurant.find_or_create_by(name: "Freebirds", location_id: 1, description: "Burritos")
Restaurant.find_or_create_by(name: "Woodstock's Pizza", location_id: 1, description: "Pizza")
Restaurant.find_or_create_by(name: "South Coast Deli", location_id: 1, description: "Sandwiches")
Restaurant.find_or_create_by(name: "Naan Stop", location_id: 1, description: "Indian food")
Restaurant.find_or_create_by(name: "Hanna Kitchen", location_id: 1, description: "Asian fusion")
Restaurant.find_or_create_by(name: "The Habit", location_id: 1, description: "SB Burgers")
Restaurant.find_or_create_by(name: "Super Cuca's", location_id: 1, description: "Mexican Burgers")
Restaurant.find_or_create_by(name: "Buddha Bowls", location_id: 1, description: "Bread Bowls")
Restaurant.find_or_create_by(name: "Poke Ceviche", location_id: 1, description: "Poke and Wraps")
Restaurant.find_or_create_by(name: "Spudnuts", location_id: 1, description: "Donuts")
Restaurant.find_or_create_by(name: "Caje", location_id: 1, description: "Hip Coffee Shop")
Restaurant.find_or_create_by(name: "Lao Wang", location_id: 1, description: "Asian food")
