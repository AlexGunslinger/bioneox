class DcplsController < ApplicationController
  before_filter :require_user
  before_filter :set_nav_top
  layout "samples", :except => [:update_city_select]
  
  # GET /dcpls
  # GET /dcpls.json
  def index
  	@title = "Dcpls List"
    @navinner = "1"
    @dcpls = Dcpl.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @dcpls }
    end
  end

  # GET /dcpls/1
  # GET /dcpls/1.json
  def show
    @dcpl = Dcpl.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @dcpl }
    end
  end

  # GET /dcpls/new
  # GET /dcpls/new.json
  def new
  	@title = "New Dcpl"
    @navinner = "2"
    @dcpl = Dcpl.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @dcpl }
    end
  end

  # GET /dcpls/1/edit
  def edit
  	@title = "Edit Dcpl"
  	@navinner = "5"
    @dcpl = Dcpl.find(params[:id])

  end

  # POST /dcpls
  # POST /dcpls.json
  def create
    @dcpl = Dcpl.new(params[:dcpl])

    respond_to do |format|
      if @dcpl.save
        format.html { redirect_to dcpls_url, notice: 'Dcpl was successfully created.' }
        format.json { render json: @dcpl, status: :created, location: @dcpl }
      else
        format.html { render action: "new" }
        format.json { render json: @dcpl.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /dcpls/1
  # PUT /dcpls/1.json
  def update
    @dcpl = Dcpl.find(params[:id])

    respond_to do |format|
      if @dcpl.update_attributes(params[:dcpl])
        format.html { redirect_to dcpls_url, notice: 'Dcpl was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @dcpl.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dcpls/1
  # DELETE /dcpls/1.json
  def destroy
    @dcpl = Dcpl.find(params[:id])
    @dcpl.destroy

    respond_to do |format|
      format.html { redirect_to dcpls_url }
      format.json { head :no_content }
    end
  end
  
  def update_city_select
  	@cities = City.where(:state_id => params[:id]).order(:name)
  end
  
  private
  
  def set_nav_top
  	@navtop = "5"
  end
  
end
