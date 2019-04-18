class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    @trips = Trip.where("date_leaving > ?", Date.today).order("date_leaving ASC").limit(3)
    @activities = Activity.where("date > ?", Date.today).order("date ASC").limit(3)
    @flats = Flat.order("RANDOM()").limit(3)
  end
end
