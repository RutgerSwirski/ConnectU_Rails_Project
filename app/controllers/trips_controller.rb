class TripsController < ApplicationController
  before_action :set_trip, only: [:show, :edit, :update, :destroy]
  skip_before_action :authenticate_user!, only: [:index, :show]
  def index
    @trips = Trip.all

    if params[:departing_from].present?
      @trips = Trip.where("departing_from ILIKE ?", "%#{params[:departing_from]}%")
    elsif params[:destination].present?
      @trips = Trip.where("destination ILIKE ?", "%#{params[:destination]}%")
    end

    if params[:departing_from].present? && params[:destination].present?
      @trips = Trip.where("departing_from ILIKE ? AND destination ILIKE ?", "%#{params[:departing_from]}%", "%#{params[:destination]}%" )
    end

    if params[:price] == "Price ASC"
      @trips = @trips.order(ticket_price_cents: :asc)
    elsif params[:price] == "Price DESC"
      @trips = @trips.order(ticket_price_cents: :desc)
    end

    @markers = @trips.map do |trip|
      {
        lat: trip.latitude,
        lng: trip.longitude
      }
    end
  end

  def show
    @trip_creator = User.find(@trip.user_id)
    @activities = Activity.near(@trip.destination, 10).where(date: @trip.date_arriving..@trip.date_leaving)
    @flats = Flat.near(@trip.destination, 20)
    @review = Review.new
  end

  def new
    @trip = Trip.new
    @trip_photos = @trip.trip_photos.build
  end

  def create
    @trip = Trip.new(trip_params)
    @trip.user = current_user
    @trip.ticket_price = (@trip.funding_total / @trip.ticket_quantity).to_f
    # raise
    if @trip.save
      if params[:trip][:trip_photos]['photo'] != nil
        params[:trip][:trip_photos]['photo'].each do |a|
          @trip_images = @trip.trip_photos.create!(photo: a)
        end
        @trip.update(available_tickets: @trip.ticket_quantity)
      end
      redirect_to trip_path(@trip)
    else
      render :new
    end
  end

  def edit
    if current_user != @trip.user
      redirect_to root_path
      flash[:alert] = 'Not Gonna Happen'
    end
    @trip_images = @trip.trip_photos.build
  end

  def update
    @trip.update(trip_params)
    if params[:trip][:trip_photos][:photo] != nil
      params[:trip][:trip_photos]['photo'].each do |a|
        @trip_images = @trip.trip_photos.create!(photo: a)
      end
    end
    redirect_to trip_path(@trip)
    flash[:notice] = 'Successfully Updated'
  end

  def destroy
    @trip.destroy
    redirect_to root_path
    flash[:notice] = 'Successfully Deleted'
  end

  private

  def set_trip
    @trip = Trip.find(params[:id])
  end

  def trip_params
    params.require(:trip).permit(:name, :destination, :description, :funding_total, :departing_from, :date_arriving, :date_leaving, :ticket_name, :ticket_description, :ticket_quantity, :ticket_price)
  end
end
