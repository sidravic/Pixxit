class UserSessionController < ApplicationController
  before_filter :check_logged_in?, :only => [:login]

  def login
    @user_session = UserSession.new
  end

  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      redirect_to user_url(current_user)
    else
      generate_flash_message
      render "login"
    end
  end

  def destroy
    @user_session = UserSession.find

    if @user_session.destroy
      redirect_to root_url
    else
      flash[:error] = "Woops looks like something went wrong. We're on it."
      redirect_to root_url
    end
  end

  private
  def generate_flash_message
    user = User.where(:email => params[:user_session][:email]).first
    if user && !user.active?
      flash[:error] = "Please activate your account by clicking on the link emailed to you."
    else
      flash.now[:error] =  "Username or password is invalid."
    end
  end


end
