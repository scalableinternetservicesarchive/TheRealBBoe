class MembersController < ApplicationController
    protect_from_forgery :except => :create 

    def index
        @member = Member.all
        render json: @member 
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
        render json: JSON[returnList]
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
