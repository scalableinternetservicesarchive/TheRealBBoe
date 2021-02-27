class HomepagesController < ApplicationController
  def index
    @user_info = {
      "name": "",
      "id": ""
    }
    @signed_in = false 
    if session.key?:user_id
      if User.exists?(id: session[:user_id])
        @user_info["name"] = User.find(session[:user_id]).name
        @user_info["id"] = session[:user_id]
        @signed_in = true
      else
        session.delete(:user_id)
      end
    end
  end

  def signin_as_guest
  	@guest_name = params[:name]
  	@user = User.new(username: nil, password: nil, name: @guest_name, is_auth: false)

    if @user.save
    	session[:user_id] = @user.id
     	render json: {status: 200, user_data: {id: @user.id, name: @user.name, username: @user.username}}
    else
     	render json: {status: 469, params: params}
    end
  end
end
