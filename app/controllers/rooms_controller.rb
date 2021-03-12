class RoomsController < ApplicationController
    protect_from_forgery :except => :create 

    def index
        @room = Room.all
#        a = get_votes_in_room("VIW0T")
        render json: @room
    end

    def existing_room_token
        render json: {"token": Room.last.token}, status: 200
    end

    def roompage
        if session.key?(:user_id) || params.has_key?(:user_id)
            @room_token = params[:token]
            user_id = (params.has_key? :user_id) ? params[:user_id] : session[:user_id]
            room = Room.cached_find_using_token(@room_token)
            user = User.cached_find(user_id)
            @user_name = user.name
            
            member = Member.cached_find(user_id, room.id)
            if !member
                member = Member.new(user_id: user_id, room_id: room.id, is_host: false, name: @user_name)
                if !member.save
                    render json: {}, status: 422
                end
            end
            @voted = member.votes != nil
            @votes = get_votes_in_room(@room_token)
            @participants = get_participants(room.id)

            location_id = room.location_id
            restaurant_list = Restaurant.cached_restaurants_in_location(location_id).paginate(:page => params[:page]).order('id DESC')
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
        render json: {room_votes: room_votes, session: session}, status: 200
    end

    def get_participants(room_id)
        members = Member.where(:room_id => room_id)
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
        return participants
    end

    def get_votes_in_room(room_token)
        room = Room.cached_find_using_token(room_token)

        Rails.cache.fetch("#{room.cache_key_with_version}/room_votes", expires_in: 12.hours) do
            
            members = Member.cached_find_room_members(room.id)
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
            return Hash[room_votes.sort_by {|k,v| v}[0..10]]
        end
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

    def create
        @location_id = params[:location_id]
        @room_name = params[:room_name]
        @user_id = (params.has_key? :user_id) ? params[:user_id] : session[:user_id]

        # @location_id = Location.where(name: @location_name).pluck(:id)[0]
        @room = Room.new(name:@room_name, location_id:@location_id)
        
        if @room.save
            @room.token = generate_room_token(@room.id)

            if !@room.save
                render json: {message: "error"}, status: 422
                return
            end

            @member = Member.new(user_id: @user_id, room_id: @room.id, is_host: true)

            if !@member.save
                render json: {message: "error"}, status: 422
                return
            else
                render json: {room_token: @room.token, id: @room.id, session: session}, status: 201
            end
        else
            render json: {message: "error"}, status: 422
        end

        
    end
end
