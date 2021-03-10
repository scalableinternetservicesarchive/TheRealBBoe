class RestaurantsController < ApplicationController
    protect_from_forgery :except => :create 

    def index
        #render json: {}, status: 200
    end

    def show	
        @restaurant = Restaurant.find(params[:id])	
        render json: @restaurant
    end	

    def seed
      #logger = Logger.new File.new('example.log', 'w')
      @n = params[:count]
      charset = Array('A'..'Z') + Array('a'..'z')
      
      begin
        for i in 1..@n.to_i do
          @location = rand(1..3)
          @name = "RandName"+ Array.new(10) { charset.sample }.join
          @desc = "RandDesc"+ Array.new(42) { charset.sample }.join
          @restaurant = Restaurant.new(name: @name, description:@desc, location_id:@location)
          @restaurant.save
        end
        render json: {}, status: 200
      rescue
        render json: {}, status: 500
      end
    end
    
    def create
      @restaurant = Restaurant.new(restaurant_params)
      if @restaurant.save
        render json: {restaurant:@restaurant}, status: 201
      else
        render json: {}, status: 422
      end 
    end

    def restaurant_params	
        params.require(:restaurant).permit(:name, :location_id, :description)	
    end	
end
