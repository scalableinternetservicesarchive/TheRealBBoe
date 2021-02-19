class LocationsController < ApplicationController

    def create
      @name = params[:name]
      @location = Location.new(name:@name)
      if @location.save
        render json: {location: @location}
      else
        render json: {status: 500}
      end 
    end
end
