class CarriersController < ApplicationController
  before_filter :require_user
  layout "samples"
   
  def index
  	@title = "Select Order"
    @navtop = "2"
    @orders = Order.for_carriers

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @orders }
    end
  end

  # GET /orders/new
  # GET /orders/new.json
  def new
  	@title = "New Order"
    @navtop = "3"
    @order = Order.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @order }
    end
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(params[:order])
    @order.submitted_by_id = current_user.id
    respond_to do |format|
      if @order.save
        format.html { redirect_to orders_url, notice: 'Order was successfully created.' }
        format.json { render json: @order, status: :created, location: @order }
      else
        format.html { render action: "new" }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  def deliver_sample
    @order = Order.find(params[:id])
    if @order.status == "In Transit"
      @order.delivered_at = Time.now
      @order.picked_up_by = params[:delivered_to]
    elsif @order.status == "Waiting for Carrier"
      @order.picked_up_at = Time.now
      @order.carrier_id = current_user.id
    end
    respond_to do |format|
      if @order.save
        format.html { redirect_to carriers_url, notice: 'Order was successfully processed.' }
        format.json { render json: @order, status: :created, location: @order }
      else
        format.html { render action: "index" }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  def tag

  end

  def tagged

  end
end
