class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user, :current_user_session, :photo_set_owner?
  clear_helpers

  def pushed
    puts "Params -#{params.inspect} "
  end

  def render_404
    return(render :status => 404, :file => '/public/404.html', :layout => false)
  end

  private
  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.user
  end

  def request_login
    unless current_user
      flash[:notice] = "Please login to view the entire post"
      redirect_to root_url
    end
  end

  def check_logged_in?
    if logged_in?
      redirect_to user_url(current_user)
    end
  end

  def logged_in?
    current_user ? true : false
  end

   def photo_set_owner?(post)
    post.user == current_user
  end


end
