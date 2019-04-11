class FriendsController < ApplicationController
	def index
		@sent_request_friends = current_user.sent_friend_requests.where(status: 'accepted')
		@recieved_request_friends = current_user.recieved_friend_requests.where(status: 'accepted')
	end
	def create
		@user = User.find(params[:profile_id])
		Friend.create(sender: current_user, recipient: @user, status: 'pending')
		redirect_to profiles_path
	end

	def update
	  @request = Friend.find(params[:id])
	  @request.update(status: 'accepted')
	  redirect_to friends_path
	end

	def destroy
		@request = Friend.find(params[:id])
		@request.destroy
		redirect_to friends_path
	end

	def my_recieved_requests
		@recieved_requests = current_user.recieved_friend_requests.where(status: 'pending')
	end

	def my_sent_requests
		@sent_requests = current_user.sent_friend_requests.where(status: 'pending')
	end
end
