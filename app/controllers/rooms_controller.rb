class RoomsController < ApplicationController
    protect_from_forgery with: :null_session

    def join_room_page
       # @restaurants = redirect_to controller: :restaurants, action: :index 

        if session.key?:user_id
            @room_token = params[:room_token]
            user_id = session[:user_id]
            room = Room.find_by(token: @room_token)

            if !Member.find_by(user_id: user_id, room: room.id)
                member = Member.new(room_id: room.id, user_id: user_id, is_host: false)
                if !member.save
                    render json: {status: 460}
                end
            end
            
            @location_id =1 
        else
            redirect_to '/'
        end
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
            render json: {status: 200, room_token: @room.token}
            # TODO: Send user to their room page
        else
            render json: {}, status: 500
        end
        #render json: {status: 400}
    end

end
