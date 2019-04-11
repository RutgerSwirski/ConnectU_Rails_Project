class MessagesController < ApplicationController
	def index
		@messages = current_user.recieved_messages.select('sender_id').group('sender_id')
	end

	def create
		@user = User.find(params[:profile_id])
	    @message = Message.new(message_params)
	    @message.sender = current_user
	    @message.recipient = @user
	    if @message.save
	      respond_to do |format|
	        format.html { redirect_to profile_path(@user) }
	        format.js  # <-- will render `app/views/messages/create.js.erb`
	      end
	    else
	      respond_to do |format|
	        format.html { render 'profiles/show' }
	        format.js  # <-- idem
	      end
	    end
	end

	private
	def message_params
    	params.require(:message).permit(:content)
  	end
end
