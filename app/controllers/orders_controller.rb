class OrdersController < ApplicationController
  before_filter :require_user, :except => [:call]
  before_filter :set_nav_top
  layout "samples", :except => [:update_order_type]
   
  def index
  	@title = "Orders"
    @navinner = "2"
    where = where2 = where3 = where4 = where5 = where6 = @datefrom = @dateto = @origin = @delivery_site = @ccc = @created_by = @sstatus = ""

    if ((params[:datefrom] != nil and params[:datefrom] != "") and (params[:dateto] != nil and params[:dateto] != ""))
      where = where + "created_at between '#{params[:datefrom].to_date.to_s} 00:00:00' and '#{params[:dateto].to_date.to_s} 23:59:59'"
      @datefrom = params[:datefrom]
      @dateto = params[:dateto]
    end

    if (params[:origin] != nil and params[:origin] != "")
      where2 = where2 + "origin_user_id = #{params[:origin]}"
      @origin = params[:origin]
    end

    if (params[:delivery_site] != nil and params[:delivery_site] != "")
      where3 = where3 + "delivery_user_id = #{params[:delivery_site]}"
      @delivery_site = params[:delivery_site]
    end

    if (params[:ccc] != nil and params[:ccc] != "")
      where4 = where4 + "carrier_id = #{params[:ccc]}"
      @ccc = params[:ccc]
    end

    if (params[:created_by] != nil and params[:created_by] != "")
      where5 = where5 + "carrier_id = #{params[:created_by]}"
      @created_by = params[:created_by]
    end



    if current_user.is_admin?

      @orders = Order.where("#{where}").where("#{where2}").where("#{where3}").where("#{where4}").where("#{where5}")

    elsif current_user.is_onsite?
      @orders = current_user.delivery_orders.where("#{where}").where("#{where2}").where("#{where3}").where("#{where4}").where("#{where5}")
    elsif current_user.is_carrier? or current_user.is_cpld?
      @orders = current_user.carrier_orders.where("#{where}").where("#{where2}").where("#{where3}").where("#{where4}").where("#{where5}")
    elsif current_user.is_doctor?
      @orders = current_user.origin_orders
    end

    if (params[:sstatus] != nil and params[:sstatus] != "")
      if params[:sstatus] == "Delivered"
        @orders = @orders.status_delivered
      elsif params[:sstatus] == "InTransit"
        @orders = @orders.status_in_transit
      elsif params[:sstatus] == "WaitingForCarrier"
        @orders = @orders.status_waiting_for_carrier
      elsif params[:sstatus] == "CarrierConfirmation"
        @orders = @orders.status_carrier_confirmation
      elsif params[:sstatus] == "OrderCreated"
        @orders = @orders.status_order_created
      end
      @sstatus = params[:sstatus]
    end

    respond_to do |format|
      format.html # index.html.erb
      format.pdf do
        pdf = OrderPdf.new(@orders, view_context)
        send_data pdf.render, filename: "orders_report.pdf", type: "application/pdf", disposition: "inline"
      end
      format.json { render json: @orders }
    end
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
    @order = Order.find(params[:id])
    @title = "Order #{@order.id}"
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
    if current_user.is_carrier?
      
    end
    respond_to do |format|
      if @order.save
        if current_user.is_doctor?
          if @order.delivery_user.valid_cell?
            @order.send_call
          end
        end
        if @order.carrier and not current_user.is_carrier?
          if @order.carrier.valid_cell?
            #if @order.urgency == "yes"
            #  @order.send_call
            #else
              @order.send_sms("si")
            #end
          end
        end
        if @order.driver and not current_user.is_driver?
          if @order.driver.valid_cell?
              @order.send_sms_to_driver("si")
          end
        end
        format.html { redirect_to orders_url, notice: 'Order was successfully created.' }
        format.json { render json: @order, status: :created, location: @order }
      else
        @title = "New Order" 
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
    #@order = Order.find(params[:id])
    #@order.carrier_id = params[:carrier_id]
    order_id = params[:assign]
    @order = Order.find(order_id)
    carrier = params["carrier#{order_id}".to_sym]
    @order.carrier_id = carrier
    @order.save
    if @order.carrier
      if @order.carrier.valid_cell?
        #if @order.urgency == "yes"
        #  @order.send_call
        #else
          @order.send_sms("no")
        #end
      end
    end
    respond_to do |format|
     # if @order.save
        format.html { redirect_to orders_url, notice: 'Carrier Company was successfully updated.' }
        format.json { head :no_content }
     # else
     #   format.html { render action: "index" }
     #   format.json { render json: @order.errors, status: :unprocessable_entity }
     # end
    end
  end

  # GET
  def call
    @order = Order.find(params[:id])

    respond_to do |format|
      format.xml #{render :xml => verb.response}
    end
  end

  def process_carrier
    band = 0
    order_id = params[:assign]
    area = params["area#{order_id}".to_sym]
    picked_up_by = params["picked_up_by#{order_id}".to_sym]
    carrier_name = params["carrier_name#{order_id}".to_sym]
    if order_id == "CarrierConfirmation" or order_id == "InTransit" or order_id == "WaitingForCarrier"
      if params[:edit]
      params[:edit].each do |id|
        order = Order.find(id[0])
        if order_id == "InTransit"
          if params[:picked_up_by] != "" and params[:picked_up_by] != nil
            order.delivered_at = Time.now
            order.picked_up_by = params[:picked_up_by]
            #@order.picked_up_by = params[:delivered_to]
          end
        elsif order_id == "CarrierConfirmation"
            order.area = params[:area]
            order.picked_up_by_id = params[:carrier_name]
        elsif order_id == "WaitingForCarrier"
            order.picked_up_at = Time.now
        end
        order.save
      end
      end
      respond_to do |format|
        format.html { redirect_to orders_url, notice: 'Order was successfully processed.' }
        format.json { render json: @order, status: :created, location: @order }
      end
    else

    @order = Order.find(order_id)
    if @order.status == "In Transit"
      if picked_up_by != "" and picked_up_by != nil
        @order.delivered_at = Time.now
        @order.picked_up_by = picked_up_by
        #@order.picked_up_by = params[:delivered_to]
      end
    elsif @order.status == "Waiting for Carrier" or @order.status == "Carrier Confirmation"
      if params["is_assign#{order_id}".to_sym] == "yes"
        band = 1
        @order.area = area
        @order.picked_up_by_id = carrier_name
      else
        @order.picked_up_at = Time.now
      end
    end
    respond_to do |format|
      if @order.save
        if band == 1
          if @order.driver
            if @order.driver.valid_cell?
                @order.send_sms_to_driver("no")
            end
          end
        end
        format.html { redirect_to orders_url, notice: 'Order was successfully processed.' }
        format.json { render json: @order, status: :created, location: @order }
      else
        format.html { render action: "index" }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
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
