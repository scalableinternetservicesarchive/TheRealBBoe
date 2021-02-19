class MemberController < ApplicationController

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
        @member = Member.new(member_params)
        @member.save    
        render json: @member
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
