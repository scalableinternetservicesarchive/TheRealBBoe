# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.find_or_create_by(id: 1, name: 'Ryan', username: 'Ryan X.', password: 'password', is_auth: true)
User.find_or_create_by(id: 2, name: 'April', username: 'aprilsanchez', password: 'password', is_auth: true)
User.find_or_create_by(id: 3, name: 'Laboni', username: 'Laboni', password: 'password', is_auth: true)
User.find_or_create_by(id: 4, name: 'Wei-Yee', username: 'weigee', password: 'password', is_auth: true)
User.find_or_create_by(id: 5, name: 'Saurav', username: 'sauravucsb', password: 'password', is_auth: true)
User.find_or_create_by(id: 6, name: 'Mat', username: 'mateolithium', password: 'password', is_auth: true)

Location.find_or_create_by(id: 1, name: "Isla Vista")
Location.find_or_create_by(id: 2, name: "Santa Barbara")
Location.find_or_create_by(id: 3, name: "Solvang")

Room.find_or_create_by(token: "ABCDE", name: "Manzanita Floor 1 Decision", location_id: 1)
Room.find_or_create_by(token: "EFGHI", name: "Take decision", location_id: 1)
Room.find_or_create_by(token: "IJKLM", name: "Food hangout", location_id: 1)
Room.find_or_create_by(token: "MNOPQ", name: "Let's party", location_id: 1)
Room.find_or_create_by(token: "QRSTU", name: "Where to go?", location_id: 1)
Room.find_or_create_by(token: "UVWXY", name: "Quick decision", location_id: 1)

Member.find_or_create_by(room_id: 1, user_id: 1, is_host: false)
Member.find_or_create_by(room_id: 1, user_id: 2, is_host: false)
Member.find_or_create_by(room_id: 1, user_id: 3, votes:"7;8;9;10;11", is_host: true)
Member.find_or_create_by(room_id: 2, user_id: 1, is_host: true)
Member.find_or_create_by(room_id: 3, user_id: 3, votes:"11;12;13", is_host: false)
Member.find_or_create_by(room_id: 2, user_id: 3, votes:"1;2;3", is_host: false)
Member.find_or_create_by(room_id: 4, user_id: 3, votes:"4;5;8;2", is_host: false)
Member.find_or_create_by(room_id: 5, user_id: 3, votes:"1;2;3", is_host: false)
Member.find_or_create_by(room_id: 5, user_id: 4, is_host: false)
Member.find_or_create_by(room_id: 6, user_id: 3, votes:"1;2;3", is_host: false)



Restaurant.find_or_create_by(id: 1, name: "Deja Vu", location_id: 1, description: "Indian food")
Restaurant.find_or_create_by(id: 2, name: "Freebirds", location_id: 1, description: "Burritos")
Restaurant.find_or_create_by(id: 3, name: "Woodstock's Pizza", location_id: 1, description: "Pizza")
Restaurant.find_or_create_by(id: 4, name: "South Coast Deli", location_id: 1, description: "Sandwiches")
Restaurant.find_or_create_by(id: 5, name: "Naan Stop", location_id: 1, description: "Indian food")
Restaurant.find_or_create_by(id: 6, name: "Hanna Kitchen", location_id: 1, description: "Asian fusion")
Restaurant.find_or_create_by(id: 7, name: "The Habit", location_id: 1, description: "SB Burgers")
Restaurant.find_or_create_by(id: 8, name: "Super Cuca's", location_id: 1, description: "Mexican Burgers")
Restaurant.find_or_create_by(id: 9, name: "Buddha Bowls", location_id: 1, description: "Bread Bowls")
Restaurant.find_or_create_by(id: 10, name: "Poke Ceviche", location_id: 1, description: "Poke and Wraps")
Restaurant.find_or_create_by(id: 11, name: "Spudnuts", location_id: 1, description: "Donuts")
Restaurant.find_or_create_by(id: 12, name: "Caje", location_id: 1, description: "Hip Coffee Shop")
Restaurant.find_or_create_by(id: 13, name: "Lao Wang", location_id: 1, description: "Asian food")
