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