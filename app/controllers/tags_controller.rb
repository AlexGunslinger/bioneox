class TagsController < ApplicationController
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
  	@title = "Tag Site"
    @navtop = "4"
    @tag = Tag.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @order }
    end
  end

  # POST /orders
  # POST /orders.json
  def create
    @tag = Tag.new(params[:tag])
    @tag.user_id = current_user.id
    respond_to do |format|
      if @tag.save
        format.html { redirect_to carriers_url, notice: 'Tag wag successfully added.' }
        format.json { render json: @tag, status: :created, location: @order }
      else
        format.html { render action: "new" }
        format.json { render json: @tag.errors, status: :unprocessable_entity }
      end
    end
  end

end
