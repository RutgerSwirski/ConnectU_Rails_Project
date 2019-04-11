class TicketsController < ApplicationController
	before_action :set_ticket

	def show
		if @ticket.order.trip != nil && (@ticket.order.trip.current_funding_amount_cents < @ticket.order.trip.funding_total_cents)
	  	redirect_to order_path(@ticket.order)
        flash[:alert] = 'Not Fully Funded!'
	  end

	  if current_user != @ticket.order.user
        redirect_to root_path
        flash[:alert] = 'Not Gonna Happen'
      end
	end

	def update
	  @ticket.update(ticket_used: true)
      redirect_to ticket_path(@ticket)
	end

	private

	def set_ticket
	  @ticket = Ticket.find(params[:id])
	end
end
