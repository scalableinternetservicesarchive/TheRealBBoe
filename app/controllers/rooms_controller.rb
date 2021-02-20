class RoomsController < ApplicationController
    protect_from_forgery with: :null_session
    def createRoomPage
    end

    def create
        @location_id = params[:location_id]
        @room_name = params[:room_name]
        

        # TODO: Generate token
        @token = "1"

       # @location_id = Location.where(name: @location_name).pluck(:id)[0]
        @room = Room.new(token:@token, name:@room_name, location_id:@location_id)
    
        if @room.save
            # TODO: Send them success
            render json: {status: 200, user_data: {token: @token}}
            # TODO: Send user to their room page
        else
            render json: {status: 500}
        end
        #render json: {status: 400}
    end

end
