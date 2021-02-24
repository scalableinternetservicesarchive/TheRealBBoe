class MembersController < ApplicationController

    def index
        @member = Member.all
        render json: @member 
    end

    def update_member_votes
        @user_votes = params[:votes]
        @token = params[:token]
        @room_id = Room.find_by(token: @token).id
        @member = Member.find_by(user_id: session[:user_id], room_id: @room_id)

        #render json:{status: 490, votes: @user_votes, member: @member, room_id: @room_id, token: @token, session: session[:user_id]}
        #render json: {status: 409, votes: @user_votes, token: @token}

        @member.votes = @user_votes
        if @member.save
            render json: {status: 200}
        else
            render json: {status: 450}
        end

        
    end

    def show
        @member = Member.find(params[:id])
        render json: @member
    end

    def create
        @member = Member.new(member_params)
        if @member.save
            #TODO: take to the room page
            render json: @member
        else
            render json: {}, status: 500
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
            render json: {}, status: 404
        end
    end
end
