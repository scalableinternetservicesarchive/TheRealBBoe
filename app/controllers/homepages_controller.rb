class HomepagesController < ApplicationController
  def index
    @user_info = {
      "name": "",
      "id": "",
      "is_auth": false,
    }
    @signed_in = false 
    if session.key?:user_id
      @user = User.find(session[:user_id])
      if @user
        @user_info["name"] = @user.name
        @user_info["id"] = session[:user_id]
        @user_info["is_auth"] = @user.is_auth
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
  	#@user = User.find_by(username: @name, password: @password)
    @user = User.find_by(username: @name)
    user_pass = @user.password
    if @user
      if user_pass!= @password
        render json: {params: params}, status: 404
      else
    	  session[:user_id] = @user.id
        render json: {user_data: {id: @user.id, name: @user.name, username: @user.username, is_auth: @user.is_auth}}, status: 200
      end
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

    render json: {}, status: 200
  end
end
