# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# User.create(name: 'Ryan', username: 'Ryan X.', password: 'password', is_auth: true)
# User.create(name: 'April', username: 'aprilsanchez', password: 'password', is_auth: true)
# User.create(name: 'Laboni', username: 'Laboni', password: 'password', is_auth: true)
# User.create(name: 'Wei-Yee', username: 'weigee', password: 'password', is_auth: true)
# User.create(name: 'Saurav', username: 'sauravucsb', password: 'password', is_auth: true)
# User.create(name: 'Mat', username: 'mateolithium', password: 'password', is_auth: true)

# Location.create(name: "Isla Vista")
# Location.create(name: "Santa Barbara")
# Location.create(name: "Solvang")

# Room.create(token: "ABCDE", name: "Manzanita Floor 1 Decision", location_id: 1)

Member.create(rooms_id: 1, users_id: 1, is_host: false)
Member.create(rooms_id: 1, users_id: 2, is_host: false)
Member.create(rooms_id: 1, users_id: 3, is_host: true)