class MembersController < ApplicationController

    def index
        @member = Member.all
        render json: @member, status: 200
    end


    #if a regular user joins, the user can get the list of all rooms it joined
    def get_rooms
        # DO NOT DELETE. Condition used for load testing
        @user_id = (params.has_key? :user_id) ? params[:user_id] : session[:user_id]
        @room_ids = Member.where(user_id: @user_id).pluck(:room_id)

        @rooms = Room.find(@room_ids)
        #render json: @rooms
        
        @roomList = []
        #@rooms.each { |room|
        for room in @rooms do
            #@room = Room.find_by(id: room_id)
            temp = {}
            temp.store("room_id",room.id)
            temp.store("room_name", room.name) 
            temp.store("room_token", room.token)
            @roomList.push(temp)
        end
        render json: {rooms: @roomList}, status: 200
    end

    def update_member_votes
        # use session if provided else param
        @user_id = (params.has_key? :user_id) ? params[:user_id] : session[:user_id]
        
        @user_votes = params[:votes]
        @token = params[:token]
        @room_id = Room.find_by(token: @token).id
        @member = Member.find_by(user_id: @user_id, room_id: @room_id)

        #render json:{status: 490, votes: @user_votes, member: @member, room_id: @room_id, token: @token, session: session[:user_id]}
        #render json: {status: 409, votes: @user_votes, token: @token}

        @member.votes = @user_votes
        if @member.save
            render json: {session: session}, status: 200
        else
            render json: {}, status: 422
        end 
    end

    def show
        @member = Member.where("room_id= ?",params[:room_id])
        returnList = []
        @member.find_each do |m|
            temp = {}
            temp.store("user_id",m[:user_id])
            temp.store("user_name", User.where(id: m[:user_id]).first[:username]) 
            temp.store("is_host",m[:is_host])
            #temp.store ("votes",m[:votes])
            returnList.push(temp)
        end
        render json: JSON[returnList], status: 200
    end

    def create
        @member = Member.new(member_params)
        if @member.save
            render json: @member
        else
            render json: {}, status: 422
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
