class OrdersController < ApplicationController
  def index
    @orders = current_user.orders.where(state: 'paid').order('created_at ASC')
  end
  def show
    @order = current_user.orders.where(state: 'paid').find(params[:id])
  end

  def create
    if params[:trip_id] != nil
      trip = Trip.find(params[:trip_id])
      if params[:orders][:number_of_orders].to_i > trip.available_tickets
        redirect_to trip_path(trip)
        flash[:alert] = 'Sorry, Not Enough Tickets Left!'
      else
        order = Order.create!(amount: trip.ticket_price, state: 'pending', user: current_user, trip: trip, number_of_orders: params[:orders][:number_of_orders])
        redirect_to new_order_payment_path(order)
      end
    elsif params[:activity_id] != nil
      activity = Activity.find(params[:activity_id])
      if params[:orders][:number_of_orders].to_i > activity.available_tickets
        redirect_to activity_path(activity)
        flash[:alert] = 'Sorry, Not Enough Tickets Left!'
      else
        order = Order.create!(amount: activity.price, state: 'pending', user: current_user, activity: activity, number_of_orders: params[:orders][:number_of_orders])
        redirect_to new_order_payment_path(order)
      end
    elsif params[:flat_id] != nil
      flat = Flat.find(params[:flat_id])
      flat_booking_start = params[:orders][:flat_booked_start_date]
      flat_booking_end = params[:orders][:flat_booked_end_date]
      flat_guests = params[:orders][:number_of_guests]
      order = Order.create!(flat_booked_start: flat_booking_start, flat_booked_end: flat_booking_end, number_of_guests: flat_guests, amount: ((flat_booking_end.to_date - flat_booking_start.to_date).to_f * flat.price).to_f, state: 'pending',number_of_orders: 1, user: current_user, flat: flat)
      redirect_to new_order_payment_path(order)
    end
  end
end
