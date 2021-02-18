class UserController < ApplicationController

  protect_from_forgery :except => :create 

  def index
    @user = User.all
    render json: @user
  end

  def show
    @user = User.find(params[:id])
    render json: @user
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.is_auth = user_params.has_key?(:password)

    if @user.save
      render json: {user: @user}
    else
      render json: {status: 200}
    end
  end

  def user_params
    params.require(:user).permit(:username, :password, :name)
  end
end
