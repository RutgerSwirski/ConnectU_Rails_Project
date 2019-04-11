class ReviewsController < ApplicationController
  def create
    if params[:trip_id] != nil
      @trip = Trip.find(params[:trip_id])
      @review = Review.new(review_params)
      @review.trip = @trip
      @review.user = current_user
      if @review.save
        respond_to do |format|
          format.html { redirect_to trip_path(@trip) }
          format.js # <-- will render `app/views/reviews/create.js.erb`
        end
      else
        respond_to do |format|
          format.html { render 'trips/show' }
          format.js # <-- idem
        end
      end
    elsif params[:activity_id] != nil
      @activity = Activity.find(params[:activity_id])
      @review = Review.new(review_params)
      @review.activity = @activity
      @review.user = current_user
      if @review.save
        respond_to do |format|
          format.html { redirect_to activity_path(@activity) }
          format.js # <-- will render `app/views/reviews/create.js.erb`
        end
      else
        respond_to do |format|
          format.html { render 'activities/show' }
          format.js # <-- idem
        end
      end
    elsif params[:flat_id] != nil
      @flat = Flat.find(params[:flat_id])
      @review = Review.new(review_params)
      @review.flat = @flat
      @review.user = current_user
      if @review.save
        respond_to do |format|
          format.html { redirect_to flat_path(@flat) }
          format.js # <-- will render `app/views/reviews/create.js.erb`
        end
      else
        respond_to do |format|
          format.html { render 'activities/show' }
          format.js # <-- idem
        end
      end
    end
  end

  private

  def review_params
    params.require(:review).permit(:review_content, :rating)
  end
end
