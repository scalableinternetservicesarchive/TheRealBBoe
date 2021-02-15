class RoomsController < ApplicationController

    def create
        @location_id = params[:location_id]
        @room_name = params[:room_name]
        @host_id = params[:host_id]

        # TODO: Generate token
        @token = "1234"

        @room = Room.new(token:@token, name:@room_name, host_id:@host_id, location_id:@location_id)
    
        if @room.save
            # TODO: Send them success
            render json: {room: @room}
            # TODO: Send user to their room page
        else
            render json: {status: 500}
        end
    end

end
