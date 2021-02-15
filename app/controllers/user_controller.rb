class UserController < ApplicationController

  def index
    @user = User.all
    render json: {users: @user}
  end

  def show
    @user = User.find(params[:id])
  end

  def new
  end

  ### NOTE: Just a hardcoded example, will need to remove hard coded values when fields are set as unique
  def create

  	@is_auth = true
  	@name = "weiyee"
  	@username = "weiyee123123"
  	@password = "123123"

    @user = User.new(is_auth: @is_auth, name:@name, username:@username, password:@password)
    if @user.save
      render json: {user: @user}
    else
      render json: {status: 200}
    end
    
  end
end
