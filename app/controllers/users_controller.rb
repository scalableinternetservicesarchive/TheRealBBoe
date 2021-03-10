class UsersController < ApplicationController

    protect_from_forgery :except => :create 	
    

    def index	
        @user = User.all	

        if params.has_key?(:room_id)	
            # get all users part of the room	
            members = Member.where(room_id: params[:room_id])	
            user_ids = members.map(&:user_id)	
            @user = @user.find(id=user_ids)	
        end	

        render json: @user, status: status
    end	

    def show	
        @user = User.find_by(params[:id])	

        if @user
            body = @user
            status = 200
        else # if user with params[:id] not found
            body = {}
            status = 404
        end
        render json: body, status: status	
    end	

    def new	
        @user = User.new	
    end	

    def create	
        @username = params[:username]
        if User.find_by(username: @username)
            render json: {}, status: 400
        else
            @user = User.new(user_params)	
            @user.is_auth = user_params.has_key?(:password)	
            @user.save
            session[:user_id] = @user.id
            render json: {user_data: {id: @user.id, name: @user.name, username: @user.username, is_auth: @user.is_auth}}, status: 201
        end
    end	

    def user_params	
        params.require(:user).permit(:username, :password, :name)	
    end	

    def destroy 	
        if User.exists? id: params[:id]	
            @user = User.find(params[:id])	
            @user.destroy	
            render json: @user	
        else	
            render json: {}, status: 404	
        end	
    end
end
