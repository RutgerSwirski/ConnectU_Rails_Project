class FlatPhotosController < ApplicationController
  def destroy
    @photo = FlatPhoto.find(params[:id])
    @photo.destroy
  end
end
