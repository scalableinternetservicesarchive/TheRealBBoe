# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# reset all id sequences to 1
ActiveRecord::Base.connection.tables.each do |t|
    ActiveRecord::Base.connection.reset_pk_sequence!(t)
end

User.find_or_create_by(name: 'Ryan', username: 'Ryan X.', password: 'password', is_auth: true)
User.find_or_create_by(name: 'April', username: 'aprilsanchez', password: 'password', is_auth: true)
User.find_or_create_by(name: 'Laboni', username: 'Laboni', password: 'password', is_auth: true)
User.find_or_create_by(name: 'Wei-Yee', username: 'weigee', password: 'password', is_auth: true)
User.find_or_create_by(name: 'Saurav', username: 'sauravucsb', password: 'password', is_auth: true)
User.find_or_create_by(name: 'Mat', username: 'mateolithium', password: 'password', is_auth: true)

Location.find_or_create_by(name: "Isla Vista")
Location.find_or_create_by(name: "Santa Barbara")
Location.find_or_create_by(name: "Solvang")


Room.find_or_create_by(token: "Z0Z05", name: "Manzanita Floor 1 Decision", location_id: 1)
Room.find_or_create_by(token: "Y0Z0B", name: "Take decision", location_id: 1)
Room.find_or_create_by(token: "X0Z0H", name: "Food hangout", location_id: 1)
Room.find_or_create_by(token: "W0Z0N", name: "Let's party", location_id: 1)
Room.find_or_create_by(token: "V0Z0T", name: "Where to go?", location_id: 1)
# Room.find_or_create_by(token: "U0Z0Z", name: "Quick decision", location_id: 1)
# Room.find_or_create_by(token: "T1Z05", name: "Room1", location_id: 1)
# Room.find_or_create_by(token: "S1Z0B", name: "Room2", location_id: 1)
# Room.find_or_create_by(token: "R1Z0H", name: "Room3", location_id: 1)
# Room.find_or_create_by(token: "Q1Z0N", name: "Room4", location_id: 1)

Member.find_or_create_by(room_id: 1, user_id: 1, name: 'Ryan', is_host: false)
Member.find_or_create_by(room_id: 1, user_id: 2, name: 'April', is_host: false)
Member.find_or_create_by(room_id: 1, user_id: 3, name: 'Laboni', votes:"7;8;9;10;11", is_host: true)
Member.find_or_create_by(room_id: 2, user_id: 1, name: 'Ryan', is_host: true)
Member.find_or_create_by(room_id: 2, user_id: 3, name: 'Laboni', votes:"1;2;3", is_host: false)
Member.find_or_create_by(room_id: 3, user_id: 3, name: 'Laboni', votes:"11;12;13", is_host: false)
Member.find_or_create_by(room_id: 3, user_id: 1, name: 'Ryan', votes:"11;12;13", is_host: false)
Member.find_or_create_by(room_id: 3, user_id: 2, name: 'April', votes:"11;12;13", is_host: true)
Member.find_or_create_by(room_id: 4, user_id: 3, name: 'Laboni', votes:"4;5;8;2", is_host: false)
Member.find_or_create_by(room_id: 4, user_id: 2, name: 'April', votes:"5;8;2", is_host: false)
Member.find_or_create_by(room_id: 4, user_id: 1, name: 'Ryan', votes:"4;8;2", is_host: true)
Member.find_or_create_by(room_id: 4, user_id: 4, name: 'Wei-Yee', votes:"4;5;8", is_host: false)
Member.find_or_create_by(room_id: 4, user_id: 5, name: 'Saurav',  is_host: false)
Member.find_or_create_by(room_id: 5, user_id: 3, name: 'Laboni', votes:"1;2;3", is_host: false)
Member.find_or_create_by(room_id: 5, user_id: 4, name: 'Wei-Yee', votes:"1;2;14", is_host: false)
Member.find_or_create_by(room_id: 5, user_id: 2, name: 'April', votes:"1;2;3;10;11", is_host: true)
Member.find_or_create_by(room_id: 5, user_id: 5, name: 'Saurav', is_host: false)
Member.find_or_create_by(room_id: 6, user_id: 1, name: 'Ryan', votes:"1;2;3", is_host: false)
Member.find_or_create_by(room_id: 6, user_id: 2, name: 'April', votes:"1;2;3", is_host: false)
Member.find_or_create_by(room_id: 6, user_id: 3, name: 'Laboni', votes:"11;12;13;3;4;6;7", is_host: false)
Member.find_or_create_by(room_id: 6, user_id: 4, name: 'Wei-Yee', votes:"11;12;13", is_host: true)
Member.find_or_create_by(room_id: 7, user_id: 3, name: 'Laboni', votes:"1;2;3;5;6;7;8;9;10", is_host: false)
Member.find_or_create_by(room_id: 7, user_id: 4, name: 'Wei-Yee', is_host: false)
Member.find_or_create_by(room_id: 7, user_id: 2, name: 'April', votes:"1;2;3;10;11", is_host: true)
Member.find_or_create_by(room_id: 7, user_id: 5, name: 'Saurav', is_host: false)
Member.find_or_create_by(room_id: 8, user_id: 3, name: 'Laboni', votes:"9;10;11;12;8;1;2", is_host: false)
Member.find_or_create_by(room_id: 8, user_id: 4, name: 'Wei-Yee', is_host: false)
Member.find_or_create_by(room_id: 8, user_id: 2, name: 'April', votes:"1;2;3;10;11", is_host: true)
Member.find_or_create_by(room_id: 8, user_id: 5, name: 'Saurav', is_host: false)
Member.find_or_create_by(room_id: 9, user_id: 3, name: 'Laboni', votes:"7;5;1;6;9;10;14", is_host: false)
Member.find_or_create_by(room_id: 9, user_id: 4, name: 'Wei-Yee', is_host: false)
Member.find_or_create_by(room_id: 9, user_id: 2, name: 'April', votes:"1;2;3;10;14", is_host: true)
Member.find_or_create_by(room_id: 9, user_id: 5, name: 'Saurav', is_host: false)
Member.find_or_create_by(room_id: 10, user_id: 3, name: 'Laboni', votes:"1;2;3", is_host: true)
Member.find_or_create_by(room_id: 10, user_id: 4, name: 'Wei-Yee', is_host: false)
Member.find_or_create_by(room_id: 10, user_id: 2, name: 'April', votes:"1;2;3;14;11", is_host: false)
Member.find_or_create_by(room_id: 10, user_id: 5, name: 'Saurav', is_host: false)


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
Restaurant.find_or_create_by(name: "Shushiya", location_id: 1, description: "Shushi place")


def generate_room_token(room_id)
    token_set_size = 36 ** 5
    token = (room_id * (36*36*6-1)) % token_set_size
    s_token = []
    
    for j in 0..4
        digit = token % 36
        token = token / 36
        index = (j*2)%5
        if digit < 10 
            s_token[index] = digit.to_s
        else
            s_token[index] = (digit + 55).chr
        end
    end
    s_token = s_token.join("")
    return s_token
end

#Restaurants random generation
@n = 1000
charset = Array('A'..'Z') + Array('a'..'z')

restaurants = []
for i in 1..@n.to_i do
    @location = rand(1..3)
    @name = "RandName"+ Array.new(10) { charset.sample }.join
    @desc = "RandDesc"+ Array.new(42) { charset.sample }.join
    restaurants << {name: @name, description:@desc, location_id:@location}
end
Restaurant.create(restaurants)


# Generate Rooms with tokens
room_count = Room.count
new_rooms = []
for i in (room_count+1)..500 do
	token = generate_room_token(i)
	new_rooms << {token: token, name: "Room"+i.to_s, location_id: (i%3)+1}
end
Room.create(new_rooms)

users = []
for i in 0..1000 do
    users << {name: "FAKE USER", username: i.to_s, password: 'password', is_auth: true}
end
User.create(users)

members = []
for i in 0..1000 do
    members << {room_id: rand(90)+11, user_id: i+1, votes:"11;12;13", is_host: false}
end
Member.create(members)