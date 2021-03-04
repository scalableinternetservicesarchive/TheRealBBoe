class RestaurantsController < ApplicationController
    protect_from_forgery :except => :create 

    def index
        #render json: {}, status: 200
    end

    def show	
        @restaurant = Restaurant.find(params[:id])	
        render json: @restaurant
    end	

    def create
      @restaurant = Restaurant.new(restaurant_params)
      if @restaurant.save
        render json: {restaurant:@restaurant}, status: 200
      else
        render json: {}, status: 422
      end 
    end

    def restaurant_params	
        params.require(:restaurant).permit(:name, :location_id, :description)	
    end	
end
