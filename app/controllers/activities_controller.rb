class ActivitiesController < ApplicationController
  before_action :set_activity, only: [:show, :edit, :update, :destroy]
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    @activities = Activity.all

    if params[:name].present?
      @activities = Activity.where("name ILIKE ?", "%#{params[:name]}%")
    elsif params[:address].present?
      @activities = Activity.where("address ILIKE ?", "%#{params[:address]}%")
    end

    if params[:name].present? && params[:address].present?
      @activities = Activity.where("name ILIKE ? AND address ILIKE ?", "%#{params[:name]}%", "%#{params[:address]}%" )
    end

    if params[:price] == "Price ASC"
      @activities = @activities.order(price_cents: :asc)
    elsif params[:price] == "Price DESC"
      @activities = @activities.order(price_cents: :desc)
    end

    @markers = @activities.map do |activity|
      {
        lat: activity.latitude,
        lng: activity.longitude
      }
    end
  end

  def show
    @activity_creator = User.find(@activity.user_id)
    @review = Review.new

    if user_signed_in?
      @favourites = current_user.favourites.map { |favourite| favourite.activity } 
    end
    
    @activity_lat_long = Activity.where(id: params[:id])
    @markers = @activity_lat_long.map do |activity|
      {
        lat: activity.latitude,
        lng: activity.longitude
      }
    end
  end

  def new
    @activity = Activity.new
    @activity_images = @activity.activity_photos.build
  end

  def create
    @activity = Activity.new(activity_params)
    @activity.user = current_user
    @activity.available_tickets = @activity.total_tickets
    if @activity.save
      params[:activity][:activity_photos]['photo'].each do |a|
        @activity_images = @activity.activity_photos.create!(photo: a)
      end
      redirect_to activity_path(@activity)
    else
      render :new
    end
  end

  def edit
    if current_user != @activity.user
      redirect_to root_path
      flash[:alert] = 'Not Gonna Happen'
    end
  end

  def update
    @activity.update(activity_params)
    if params[:activity][:activity_photos][:photo] != nil
      params[:activity][:activity_photos]['photo'].each do |a|
        @activity_images = @activity.activity_photos.create!(photo: a)
      end
    end
    redirect_to activity_path(@activity)
    flash[:notice] = 'Successfully Updated'
  end

  def destroy
    @activity.destroy
    redirect_to root_path
    flash[:notice] = 'Successfully Deleted'
  end

  private

  def set_activity
    @activity = Activity.find(params[:id])
  end

  def activity_params
    params.require(:activity).permit(:name, :date, :address, :description, :price, :total_tickets, activity_photos_attributes: [:id, :user_id, :photo])
  end
end
