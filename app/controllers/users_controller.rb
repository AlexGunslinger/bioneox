class UsersController < ApplicationController
  before_filter :require_user
  before_filter :set_nav_top
  layout "samples"
  #require 'rqrcode'	
  
  # GET /users
  # GET /users.json
  def index
  	#@qr = RQRCode::QRCode.new(request.url, :size => 6)

  	@title = "Users List"
    @navinner = "1"
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
  	@title = "New User"
    @navinner = "2"
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
      #format.svg { render :qrcode => request.url, :level => :h, :unit => 10 }
  	  #format.png { render :qrcode => request.url }
    end
  end

  # GET /users/1/edit
  def edit
  	@title = "Edit User"
  	@navinner = "5"
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    if params[:is_site] == "yes"
      @user = User.new(params[:user])
      @user.username = @user.name
      @user.cell_number = "5555555555"
      @user.email = (0...8).map{65.+(rand(26)).chr}.join + "@bioneox.com"
    else
      @user = User.new(params[:user])
    end
    respond_to do |format|
      if @user.save
        if params[:is_site] == "yes"
          format.html { redirect_to orders_url, notive: 'Site was successfully created.' }
        else
          format.html { redirect_to users_url, notive: 'User was successfully created.' }
        end
        format.json { render json: @user, status: :created, location: @user }
      else
        if params[:is_site] == "yes"
          format.html { render action: "new", controller: "site" }
        else
          format.html { render action: "new" }
        end
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        if current_user.is_admin?
          format.html { redirect_to users_url, notice: 'User was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { redirect_to orders_url, notice: 'User was successfully updated.' }
          format.json { head :no_content }
        end
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  private
  
  def set_nav_top
  	@navtop = "3"
  end

end
