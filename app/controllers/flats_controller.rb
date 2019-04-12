class FlatsController < ApplicationController
  before_action :set_flat, only: [:show, :edit, :update, :destroy]
  skip_before_action :authenticate_user!, only: [:index, :show]
  def index
    @flats = Flat.where.not(latitude: nil, longitude: nil)

    if params[:name].present?
      @flats = Flat.where("name ILIKE ?", "%#{params[:name]}%")
    elsif params[:address].present?
      @flats = Flat.where("address ILIKE ?", "%#{params[:address]}%")
    end

    if params[:name].present? && params[:address].present?
      @flats = @flats.where("name ILIKE ? AND address ILIKE ?", "%#{params[:name]}%", "%#{params[:address]}%" )
    end

    if params[:price] == "Price ASC"
      @flats = @flats.order(price_cents: :asc)
    elsif params[:price] == "Price DESC"
      @flats = @flats.order(price_cents: :desc)
    end

    @markers = @flats.map do |flat|
      {
        lat: flat.latitude,
        lng: flat.longitude
      }
    end
  end

  def show
    @review = Review.new

    if user_signed_in?
      @favourites = current_user.favourites.map { |favourite| favourite.flat }
    end 

    @flat_lat_long = Flat.where(id: params[:id])
    @markers = @flat_lat_long.map do |flat|
      {
        lat: flat.latitude,
        lng: flat.longitude
      }
    end
  end

  def new
    @flat = Flat.new
    @flat_images = @flat.flat_photos.build
  end

  def create
    @flat = Flat.new(flat_params)
    @flat.user = current_user
    if @flat.save
      if params[:flat][:flat_photos][:photo] != nil
        params[:flat][:flat_photos]['photo'].each do |a|
          @flat_images = @flat.flat_photos.create!(photo: a)
        end
      end
      redirect_to flat_path(@flat)
    else
      render :new
    end
  end

  def edit
    if current_user != @flat.user
      redirect_to root_path
      flash[:alert] = 'Not Gonna Happen'
    end
    @flat_images = @flat.flat_photos.build
  end

  def update
    @flat.update(flat_params)
    if params[:flat][:flat_photos][:photo] != nil
      params[:flat][:flat_photos]['photo'].each do |a|
        @flat_images = @flat.flat_photos.create!(photo: a)
      end
    end
    redirect_to flat_path(@flat)
    flash[:notice] = 'Successfully Updated'
  end

  def destroy
    @flat.destroy
    redirect_to root_path
  end

  private

  def set_flat
    @flat = Flat.find(params[:id])
  end

  def flat_params
    params.require(:flat).permit(:name, :description, :address, :latitude, :longitude, :price, flat_photos_attributes: [:id, :user_id, :photo])
  end
end
