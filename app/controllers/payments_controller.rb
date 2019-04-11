class PaymentsController < ApplicationController
  before_action :set_order
  def new
  end

  def create
  customer = Stripe::Customer.create(
    source: params[:stripeToken],
    email:  params[:stripeEmail]
  )

  charge = Stripe::Charge.create(
    customer:     customer.id,   # You should store this customer id and re-use it.
    amount:       (@order.number_of_orders * @order.amount_cents),
    description:  "Order #{@order.id}",
    currency:     @order.amount.currency
  )
  current_user.orders.last(@order.number_of_orders).each do |order|
    order.update(payment: charge.to_json, state: 'paid')
  end

  if @order.trip != nil
    @order.trip.update(available_tickets: (@order.trip.available_tickets - @order.number_of_orders), current_funding_amount: (@order.trip.current_funding_amount += (@order.number_of_orders * @order.trip.ticket_price)))
    @order.number_of_orders.times do
      Ticket.create(qr_code: 'test', order: current_user.orders.last)
    end
  end

  if @order.activity != nil
    @order.number_of_orders.times do
      Ticket.create(qr_code: 'test', order: current_user.orders.last)
    end
    @order.activity.update(available_tickets: (@order.activity.available_tickets - @order.number_of_orders))
  end

  redirect_to order_path(@order)
  rescue Stripe::CardError => e
    flash[:alert] = e.message
    redirect_to new_order_payment_path(@order)
  end

  private

  def set_order
    @order = current_user.orders.where(state: 'pending').find(params[:order_id])
  end
end
