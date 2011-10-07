class UsersController < ApplicationController
  before_filter :request_login, :only => [:show, :destroy, :edit]
  before_filter :get_user, :only => [:show, :destroy, :edit]

  def new
    @user = User.new(params[:user])
  end

  def create
    @user = User.new(params[:user])

    if @user.save
      Mailman.activation(@user).deliver
      flash[:notice] = "Your account has been successfully created. An activation email has been sent to your account. " +
          "Please click on the activation link to activate your account."
      redirect_to login_url
    else
      render "new"
    end
  end

  def edit
    #uses before filter
  end

  def show
    #uses before filter
  end

  def update
  end

  def destroy
     #uses before filter

    if @user.destroy
      redirect_to root_url
    else
      flash[:notice] = "Something seems to have gone wrong."
      redirect_to root_url
    end
  end

  def activate
    token = params[:token]
    if token
      @user = User.where(:perishable_token => token).first

      if @user
        @user.activate!
        @user.reset_perishable_token!
        flash[:notice] = "Your account has been successfully activated."
      else
        flash[:error] = "Looks like your using an invalid token."
      end

      redirect_to login_url
    end
  end

  private

  def get_user
    @user = User.find(params[:id])
  end
end
