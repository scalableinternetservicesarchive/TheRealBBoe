class HomepagesController < ApplicationController
  def index
    @user_info = {
      "name": "",
      "id": "",
      "is_auth": false,
    }
    @signed_in = false 
    if session.key?:user_id
      if User.exists?(id: session[:user_id])
        @user_info["name"] = User.find(session[:user_id]).name
        @user_info["id"] = session[:user_id]
        @user_info["is_auth"] = User.find(session[:user_id]).is_auth
        @signed_in = true
      else
        session.delete(:user_id)
      end
    end
  end

  def log_out
    session.delete(:user_id)
    render json: {}, status: 200
  end

  def signin_as_guest
  	@guest_name = params[:name]
  	@user = User.new(username: nil, password: nil, name: @guest_name, is_auth: false)

    if @user.save
    	session[:user_id] = @user.id
     	render json: {user_data: {id: @user.id, name: @user.name, username: @user.username, is_auth:false}, session: session}, status: 200
    else # could not process, return 422
     	render json: {params: params}, status: 422
    end
  end


  def add_guest_name
    @guest_name = params[:name]
    @id = session[:user_id]
    @user = User.find_by(id: @id)
    if @user
      @user.update_attribute(:name, @guest_name)
      render json: {user_id: @id}, status: 200
    else
      render json: {params: params}, status: 404
    end
  end


  def signin
  	@name = params[:username]
    @password = params[:password]
  	@user = User.find_by(username: @name, password: @password)
    if @user
    	session[:user_id] = @user.id
        render json: {user_data: {id: @user.id, name: @user.name, username: @user.username, is_auth: @user.is_auth}}, status: 200
    else
       render json: {params: params}, status: 404
    end
  end

  def reset_db
    Member.delete_all
    Room.delete_all
    User.delete_all
    Restaurant.delete_all
    Location.delete_all

    Rails.application.load_seed

    #Restaurants random generation

    @n = 10000
    charset = Array('A'..'Z') + Array('a'..'z')
    begin
      for i in 1..@n.to_i do
        @location = rand(1..3)
        @name = "RandName"+ Array.new(10) { charset.sample }.join
        @desc = "RandDesc"+ Array.new(42) { charset.sample }.join
        @restaurant = Restaurant.new(name: @name, description:@desc, location_id:@location)
        @restaurant.save
      end
    rescue
      render json: {}, status: 500
    end

    render json: {}, status: 200
  end
end
