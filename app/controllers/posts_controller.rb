class PostsController < ApplicationController
  before_filter :request_login, :except => [:display, :index]
  before_filter :fetch_user, :except => [:display, :show]
  before_filter :fetch_post, :only => [ :edit, :update, :destroy, :publish, :unpublish]

  def new
    @post = @user.posts.new
    0.upto(4) do
      @post.images.build
    end
  end

  def create
    @post = @user.posts.build(params[:post])

    if @post.save
      flash[:notice] = "Your post has been successfully saved."
      redirect_to user_posts_url(@user)
    else
      0.upto(4) do
        @post.images.build
      end
      render "new"
    end
  end

  def show
     @post = @user.posts.find(params[:id])
  end

  def edit
    0.upto(4 - @post.images.size) do
      @post.images.build
    end
  end

  def update
    if @post.update_attributes(params[:post])
      flash[:notice] = "Your post has been successfully updated."
      redirect_to user_posts_url(@user)
    else
      0.upto(4 - @post.images.size) do
        @post.images.build
      end
      render "edit"
    end
  end

  def destroy
    if @post.destroy
      flash[:notice] = "Your post has been successfully deleted."
    end

    redirect_to user_posts_url(@user)
  end

  def index
    @posts = @user.posts.order("created_at DESC")
  end

  def publish
    if !@post.published? && photo_set_owner?(@post)
      flash[:notice]="Your post has been successfully published"
      @post.publish!
    end

      redirect_to user_posts_url(@user)
  end

  def unpublish
    if @post.published? && photo_set_owner?(@post)
      flash[:notice] = "Your post has been successfully unpublished"
      @post.unpublish!
    end

    redirect_to user_posts_url(@user)
  end

  def display
    @user = User.where(:slug => params[:slug]).includes(:profile).first

    if @user
      @posts = @user.posts.order("created_at DESC").limit(5)
      render :template => "posts/index"
    else
      render_404
    end
  end

  private

  def fetch_post
    @post = @user.posts.find(params[:id])
  end

  def fetch_user
    @user = User.find(params[:user_id])
    rescue ActiveRecord::RecordNotFound => e
    render_404 unless @user
  end
 end
