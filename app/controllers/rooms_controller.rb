class RoomsController < ApplicationController
    protect_from_forgery with: :null_session

    def index
        @room = Room.all	
        render json: @room
    end

    def roompage
        if session.key?(:user_id) || params.has_key?(:user_id)
            @room_token = params[:token]
            user_id = (params.has_key? :user_id) ? params[:user_id] : session[:user_id]
            room = Room.find_by(token: @room_token)
            @user_name = User.find_by(id: user_id).name
            
            member = Member.find_by(user_id: user_id, room_id: room.id)
            if !member
                member = Member.new(user_id: user_id, room_id: room.id, is_host: false)
                if !member.save
                    render json: {}, status: 422
                end
            end
            @voted = member.votes != nil
            @votes = get_votes_in_room(@room_token)
            @participants = get_participants(room.id)

            location_id = room.location_id
            restaurant_list = Restaurant.where(location_id: location_id)
            @restaurants = {}
            for restaurant in restaurant_list do
                @restaurants[restaurant.id] = restaurant
            end
        else
            redirect_to "/"
        end
    end

    def join_room
        if Room.exists?(token: params[:token])
            redirect_to :action => "roompage", :token => params[:token]
        else
            render json: {token: params[:token]}, status: 404
        end
    end

    def room_votes
        room_token = params[:room_token]
        room_votes = get_votes_in_room(room_token)
        render json: {room_votes: room_votes}, status: 200
    end

    def get_participants(room_id)
    #def get_participants
        members = Member.where(:room_id => room_id)
       # members = Member.where(:room_id=> params[:room_id])
        member_ids_votes = members.pluck(:user_id, :votes)
        member_ids = members.pluck(:user_id)
        member_votes = members.pluck(:votes)
        users = User.find(member_ids)
        ids_with_votes = []
        ids_without_votes = []
        for member in member_ids_votes do
            if member[1]!= nil
                ids_with_votes.push(member[0])
            end
        end
        participants = {}
        for user in users do
            if ids_with_votes.include? user.id
                participants[user.name] = true
            else
                participants[user.name] = false
            end 
        end

        

        #render json:participants
        
        '''participants = {}
        for member in members do
            if member != nil
                user  = User.find_by(id: member.user_id)
                if member.votes != nil
                    participants[user.name] = true;
                else
                    participants[user.name] = false;
                end
            end
        end'''

        return participants
    end

    def get_votes_in_room(room_token)
        room_id = Room.find_by(token: room_token).id
        members = Member.where(:room_id => room_id)

        room_votes = {}
        for member in members do
            if member != nil and member.votes != nil
                member_votes = member.votes.split(";");
                for loc_id in member_votes do 
                    if !room_votes.key?loc_id 
                        room_votes[loc_id] = 0
                    end
                    room_votes[loc_id] += 1;
                end 
            end
        end

        return room_votes
    end

    def show 
        status = 404
        if params.has_key?(:id)
            @room = Room.find params[:id]
            status = 200
        elsif params.has_key?(:token)
            @room = Room.find_by! token: params[:token]
            status = 200
        end
        render json: @room, status: status
    end

    def create
        @location_id = params[:location_id]
        @room_name = params[:room_name]

        # @location_id = Location.where(name: @location_name).pluck(:id)[0]
        @room = Room.new(name:@room_name, location_id:@location_id)

        # generate token
        @room.token = loop do
            new_token = SecureRandom.hex(4)
            break new_token unless Room.exists? token: new_token
        end
    
        if @room.save
            # TODO: Send them success
            render json: {room_token: @room.token, id: @room.id}, status: 200
            # TODO: Send user to their room page
        else
            render json: {}, status: 422
        end
    end
end
