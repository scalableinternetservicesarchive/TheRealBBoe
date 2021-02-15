class MembersController < ApplicationController
    def create
        @rooms_id = params[:rooms_id]
        @users_id = params[:users_id]

        @member = Member.new(users_id:@users_id, rooms_id:@rooms_id)
    
        if @member.save
            #TODO: take to the room page
            render json: {member: @member}
        else
            render json: {status: 500}
        end
    end
end
