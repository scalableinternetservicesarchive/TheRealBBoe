class RoomsController < ApplicationController
    protect_from_forgery with: :null_session

    def roompage
        if session.key?:user_id
            @room_token = params[:token]
            user_id = session[:user_id]
            room = Room.find_by(token: @room_token)
            #if no record is found for the token ; invalid token
            #if room == nil 
             #   render json: {status: 469, token: @room_token}
              #  return 
            #end
            @location_id = room.location_id

            if !Member.find_by(user_id: user_id, room: room.id)
                member = Member.new(room_id: room.id, user_id: user_id, is_host: false)
                if !member.save
                    render json: {status: 460}
                end
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
