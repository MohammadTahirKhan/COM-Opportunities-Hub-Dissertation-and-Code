class PostsController < ApplicationController
    before_action :set_posts, only: %i[ show edit update destroy publish]
    before_action :authenticate_user!
    # before_action :set_posts2, only: %i[ 
    before_action :require_user

  def require_user
    unless current_user.user_role == "0" || current_user.user_role == "2" || current_user.user_role == "1"
      redirect_to root_path
    end
  end
  
    # GET /posts
    def index
      @visibility = params[:visibility]
      case @visibility
      when 'upcoming'
        if current_user.user_role == "0" || current_user.user_role == "2"
          @posts = Post.where('end_date >= ?', Date.today).where(published: true).order(end_date: :asc)
        else
          redirect_to root_path
        end
      when 'recent'
        @posts = Post.where('end_date < ?', Date.today).where(published: true).order(end_date: :asc)
      when 'archives'
        if current_user.user_role == "0" || current_user.user_role == "2"
          @posts = Post.where('end_date < ?', Date.today - 1.year).where(published: true).order(end_date: :asc)
        else
          redirect_to root_path
        end
      when 'history'
        if current_user.user_role == "1" || current_user.user_role == "2"
          @posts = Post.where(email: current_user.email).order(end_date: :asc)
        else
          redirect_to root_path
        end
      when 'admin'
        if current_user.user_role == "2"
          @posts = Post.where(published: false).order(end_date: :asc)
        else
          redirect_to root_path
        end

      else
        redirect_to root_path
      end
    end

  
    # GET /posts/1
    def show
    end
  
    # GET /posts/new
    def new
      if current_user.user_role == "1" || current_user.user_role == "2"
        @post = Post.new
      else
        redirect_to root_path
      end
    end

    # GET /posts/1/publish
    def approve
      if current_user.user_role == "2"
        @post = Post.find(params[:id])
        @post.update(published: true)
        redirect_to posts_path, notice: "Post was successfully published."
      else
        redirect_to root_path
      end
    end
    
  
    # GET /posts/1/edit
    def edit
      if current_user.user_role != "2" && current_user.email != @post.email && @post.end_date < Date.today
        redirect_to root_path
      end
    end
  
    # POST /posts
    def create
      if current_user.user_role == "1" || current_user.user_role == "2"
        @post = Post.new(post_params)
        if @post.save
          redirect_to posts_path, notice: "post was successfully created."
        else
          flash[:alert] = "Failed to create post, please fill in all required(*) fields or check for errors"
          flash[:alert] = "Start date can't be after end date" if @post.start_date.present? && @post.end_date.present? && @post.start_date > @post.end_date
          flash[:alert] = "Start date and End date can't be before today" if @post.start_date.present? && @post.start_date < Date.today || @post.end_date.present? && @post.end_date < Date.today

          if @post.start_date.blank? || @post.end_date.blank?
            flash[:alert] = "Start date and End date can't be blank"
          end
          render :new, status: :unprocessable_entity
        end
      else
        redirect_to root_path
      end
    end
  
    # PATCH/PUT /posts/1
    def update
      publish = params[:publish]
      if publish == "true"
        if current_user.user_role == "2"
          @post.update(published: true)
          redirect_to posts_path, notice: "Post was successfully published."
        else
          redirect_to root_path
        end
      end
      if current_user.user_role == "2" || current_user.email == @post.email
      
        if @post.update(post_params)
          @post.update(published: false)
          redirect_to post_path, notice: "post was successfully updated, an admin needs to publish it for it to be visible to others."
        else
          render :edit, status: :unprocessable_entity
        end
      else
        redirect_to root_path
      end
    end
  
    # DELETE /posts/1
    def destroy
      if current_user.user_role == "2" || current_user.email == @post.email
        @post.destroy
        redirect_to post_url, notice: "post was successfully destroyed."
      else
        redirect_to root_path
      end
    end
  
    private
      # Use callbacks to share common setup or constraints between actions.
      def set_posts
          @post = Post.find(params[:id])
        
      end
  
      
      # Only allow a list of trusted parameters through.
      def post_params
        params.require(:post).permit!
      end

  end
  