class LocationsController < ApplicationController

    def index
        @location = Location.all	
        render json: @location	
    end

    def create
      @name = params[:name]
      @location = Location.new(name:@name)
      if @location.save
        render json: {location: @location}, status: 201
      else
        render json: {}, status: 422
      end 
    end
end
