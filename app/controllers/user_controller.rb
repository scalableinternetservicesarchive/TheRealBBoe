class UserController < ApplicationController

  protect_from_forgery :except => :create 

  def index
    @user = User.all

    puts params.has_key? :id

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
      render json: @user
    else
      render json: {status: 200}
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
        render json: {status: 404}
    end
  end
end
