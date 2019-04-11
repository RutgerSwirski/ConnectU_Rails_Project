class TripPhotosController < ApplicationController
  def destroy
    @photo = TripPhoto.find(params[:id])
    @photo.destroy
  end
end
