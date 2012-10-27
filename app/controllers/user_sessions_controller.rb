class UserSessionsController < ApplicationController
  layout "login"

  def new
    @user_session = UserSession.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user_session }
    end
  end

  def create
    @user_session = UserSession.new(params[:user_session])

    respond_to do |format|
      if @user_session.save
        if current_user.is_admin?
          format.html { redirect_to users_url, notice: 'Successfully logged in.' }
          format.json { render json: @user_session, status: :created, location: @user_session }
        elsif current_user.is_onsite?
          format.html { redirect_to orders_url, notice: 'Successfully logged in.' }
          format.json { render json: @user_session, status: :created, location: @user_session }
        elsif current_user.is_carrier?
          format.html { redirect_to orders_url, notice: 'Successfully logged in.' }
          format.json { render json: @user_session, status: :created, location: @user_session }
        elsif current_user.is_doctor?
          format.html { redirect_to orders_url, notice: 'Successfully logged in.' }
          format.json { render json: @user_session, status: :created, location: @user_session }
        end
      else
        format.html { render action: "new" }
        format.json { render json: @user_session.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    current_user_session.destroy
    respond_to do |format|
      format.html { redirect_to new_user_session_url, notice: 'Successfully logged out.' }
      format.json { head :no_content }
    end
  end

end
