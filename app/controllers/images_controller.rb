class ImagesController < ApplicationController
  before_filter :fetch_user, :only => [:destroy]

  def destroy
    @post = Post.find(params[:post_id])
    @image = @post.images.find(params[:id])

    if @image
      destroy_resource
    else
      generate_error_message
      redirect_to user_posts_url(@user)
    end


  end

  private

  def generate_error_message
    flash[:notice] = "This image does not exist"
  end

  def destroy_resource
    if @post.last_image?
      @post.destroy
      flash[:notice] = "This photoset has been successfully removed."
      redirect_to user_posts_url(@user)
    else
      @image.destroy
      flash[:notice] = "This image has been successfully removed from the photoset."
      redirect_to edit_user_post_url(@user,@post)
    end
  end

  def fetch_user
    @user = User.find(params[:user_id])
  rescue ActiveRecord::RecordNotFound => e
    render_404 unless @user
  end

end
