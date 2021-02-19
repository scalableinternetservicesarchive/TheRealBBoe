class MembersController < ApplicationController
    protect_from_forgery :except => :create 

    def index
        @member = Member.all
        render json: @member 
    end

    def show
        @member = Member.find(params[:id])
        render json: @member
    end

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

    def member_params
        params.require(:member).permit(:user_id, :room_id, :is_host)
    end
    
    def destroy 
        if Member.exists? id: params[:id]
            @member = Member.find(params[:id])
            @member.destroy
            render json: @member
        else
            render json: {status: 404}
        end
    end
end