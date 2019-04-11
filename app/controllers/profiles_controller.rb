class ProfilesController < ApplicationController
  def my_profile
    @my_location = Geocoder.search(request.ip)
  end

  def index
    @users = User.all

     if params[:first_name].present?
      @users = User.where("first_name ILIKE ?", "%#{params[:first_name]}%")
    elsif params[:last_name].present?
      @users = User.where("last_name ILIKE ?", "%#{params[:last_name]}%")
    end

    if params[:first_name].present? && params[:last_name].present?
      @users = @users.where("first_name ILIKE ? AND last_name ILIKE ?", "%#{params[:first_name]}%", "%#{params[:last_name]}%" )
    end

    @sent_requests_ids = current_user.sent_friend_requests.where(status: 'pending').map { |request| request.recipient_id } 
    @recieved_requests_ids = current_user.recieved_friend_requests.where(status: 'pending').map { |request| request.sender_id }
    @accepted_recieved_requests_ids = current_user.recieved_friend_requests.where(status: 'accepted').map { |request| request.sender_id }
    @accepted_sent_requests_ids = current_user.sent_friend_requests.where(status: 'accepted').map { |request| request.recipient_id }
  end

  def show
    @user = User.find(params[:id])
    @user_location = Geocoder.search(request.ip)
    @message = Message.new

    @recieved_messages = @user.sent_messages.where(recipient: current_user)
    @sent_messages = current_user.sent_messages.where(recipient: @user)
  end

  def my_hosted
  	@trips = Trip.where(user: current_user)
  	@activities = Activity.where(user: current_user)
  	@flats = Flat.where(user: current_user)
  end
end
