class OrdersController < ApplicationController
  before_filter :require_user
  before_filter :set_nav_top
  layout "samples", :except => [:update_order_type]
   
  def index
  	@title = "Orders"
    @navinner = "2"
    if current_user.is_admin?
      @orders = Order.all
    elsif current_user.is_onsite?
      @orders = current_user.delivery_orders
    elsif current_user.is_carrier?
      @orders = current_user.carrier_orders
    elsif current_user.is_doctor?
      @orders = current_user.origin_orders
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @orders }
    end
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
    @order = Order.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @order }
    end
  end

  # GET /orders/new
  # GET /orders/new.json
  def new
  	@title = "New Order"
    @navinner = "1"
    @order = Order.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @order }
    end
  end

  # GET /orders/1/edit
  def edit
  	@title = "Update Order"
  	@navinner = "5"
    @order = Order.find(params[:id])
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

  # PUT /orders/1
  # PUT /orders/1.json
  def update
    @order = Order.find(params[:id])

    respond_to do |format|
      if @order.update_attributes(params[:order])
        format.html { redirect_to orders_url, notice: 'Order was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  def add_cc
    @order = Order.find(params[:id])
    @order.carrier_id = params[:carrier_id]
    respond_to do |format|
      if @order.save
        format.html { redirect_to orders_url, notice: 'Carrier Company was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "index" }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  def add_area
    @order = Order.find(params[:id])
    @order.area = params[:area]
    @order.carrier_name = params[:carrier_name]
    respond_to do |format|
      if @order.save
        format.html { redirect_to orders_url, notice: 'Order was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "index" }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  def process_carrier
    @order = Order.find(params[:id])
    if @order.status == "In Transit"
      @order.delivered_at = Time.now
      #@order.picked_up_by = params[:delivered_to]
    elsif @order.status == "Waiting for Carrier"
      @order.picked_up_at = Time.now
      @order.carrier_id = current_user.id
    end
    respond_to do |format|
      if @order.save
        format.html { redirect_to orders_url, notice: 'Order was successfully processed.' }
        format.json { render json: @order, status: :created, location: @order }
      else
        format.html { render action: "index" }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order = Order.find(params[:id])
    @order.destroy

    respond_to do |format|
      format.html { redirect_to orders_url }
      format.json { head :no_content }
    end
  end
  
  def update_order_type
	@order_type = OrderType.find(params[:id])
  end
  
    private
  
  def set_nav_top
  	@navtop = "2"
  end
end
