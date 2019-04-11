class FavouritesController < ApplicationController
	def index
		@favourites = current_user.favourites
	end

	def create
		if params[:trip_id] != nil
			@favourite = Favourite.new
			@trip = Trip.find(params[:trip_id])
		    @favourite.user = current_user
		    @favourite.trip = @trip
		    if @favourite.save
		      redirect_to trip_path(@trip)
		    else
		      render 'trip/show'
		    end
		elsif params[:flat_id] != nil
			@favourite = Favourite.new
			@flat = Flat.find(params[:flat_id])
		    @favourite.user = current_user
		    @favourite.flat = @flat
		    if @favourite.save
		      redirect_to flat_path(@flat)
		    else
		      render 'flat/show'
		    end
		elsif params[:activity_id] != nil
			@favourite = Favourite.new
			@activity = Activity.find(params[:activity_id])
		    @favourite.user = current_user
		    @favourite.activity = @activity
		    if @favourite.save
		      redirect_to activity_path(@activity)
		    else
		      render 'activity/show'
		    end
		end
	end

	def destroy
		@favourite = Favourite.find(params[:id])
		@favourite.destroy
		redirect_to favourites_path
	end
end
