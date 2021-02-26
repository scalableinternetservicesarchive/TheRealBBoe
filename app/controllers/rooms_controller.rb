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
            

            member = Member.find_by(user_id: user_id, room_id: room.id)
            if !member
                member = Member.new(user_id: user_id, room_id: room.id, is_host: false)
                if !member.save
                    render json: {status: 460}
                end
            end
            @voted = member.votes != nil

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
        if Room.exists?(token: params[:token])== false
            #render json: {status: 469, token: params[:token]}
            return
        else
        redirect_to :action => "roompage", :token => params[:token]
        end
    end

    def room_votes

        room_token = params[:room_token]
        room_id = Room.find_by(token: room_token).id

        members = Member.where(:room_id => room_id)

        room_votes = {}
        for member in members do 
            member_votes = member.votes.split(";");
            for loc_id in member_votes do 
                if !room_votes.key?loc_id 
                    room_votes[loc_id] = 0
                end
                room_votes[loc_id] += 1;
            end 
        end

        render json: {status: 200, room_votes: room_votes}
    end

    def show 
        if params.has_key?(:id)
            @room = Room.find params[:id]
        elsif params.has_key?(:token)
            @room = Room.find_by! token: params[:token]
        end
        render json: @room	
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
            render json: {status: 200, room_token: @room.token, id: @room.id}
            # TODO: Send user to their room page
        else
            render json: {}, status: 500
        end
        #render json: {status: 400}
    end

end
