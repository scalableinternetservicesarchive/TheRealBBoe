class RestaurantsController < ApplicationController
    protect_from_forgery :except => :create 

    def index
        @restaurant = Restaurant.all
        if params.has_key?(:location_id)
            # get all restaurants in certain location
            @restaurant = @restaurant.where(location_id: params[:location_id])
        end
        render json: {data: @restaurant} 
    end

    def show	
        @restaurant = Restaurant.find(params[:id])	
        render json: @restaurant	
    end	

    def create
        @restaurant = Restaurant.new(restaurant_params)	
        @restaurant.save	
        render json: @restaurant
    end

    def restaurant_params	
        params.require(:restaurant).permit(:name, :location_id, :description)	
    end	
end
