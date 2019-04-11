class ActivityPhotosController < ApplicationController
  def destroy
    @photo = ActivityPhoto.find(params[:id])
    @photo.destroy
  end
end
