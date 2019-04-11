class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    @trips = Trip.order("date_leaving ASC").limit(9)
    @activities = Activity.order("date ASC").limit(9)
    @flats = Flat.order("RANDOM()").limit(9)
  end
end
