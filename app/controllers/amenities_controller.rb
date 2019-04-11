class AmenitiesController < ApplicationController
  before_action :set_flat
  def new
    @amenity = Amenity.new
  end

  def create
    @amenity = Amenity.new(amenity_params)
    @amenity.flat = @flat
    if @amenity.save
      redirect_to flat_path(@flat)
      flash[:notice] = 'Successfully Added'
    else
      render :new
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def set_flat
    @flat = Flat.find(params[:flat_id])
  end

  def amenity_params
    params.require(:amenity).permit(:name, :quantity)
  end
end
