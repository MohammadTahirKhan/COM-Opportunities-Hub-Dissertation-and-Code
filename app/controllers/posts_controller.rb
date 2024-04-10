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
      Post.all.each do |post|
        if post.recurring == true
          if post.end_date < Date.today
            if post.recurring_interval_num.present? && post.recurring_interval_unit.present?
              post.update(start_date: post.start_date + post.recurring_interval_num.send(post.recurring_interval_unit))
              post.update(end_date: post.end_date + post.recurring_interval_num.send(post.recurring_interval_unit))
              if post.deadline.present?
                post.update(deadline: post.deadline + post.recurring_interval_num.send(post.recurring_interval_unit))
              end
            end
          end
        end
      end
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
      when 'saved'
        if current_user.user_role == "0"
          @posts = []
          for post in Post.all
            if current_user.saved_post_ids.include?(post.id)
              @posts += [post]
            end
          end
          
        else
          redirect_to root_path
        end
      when 'email'
        if current_user.user_role == "2"
          @posts = Post.where(emailed: false || nil).where(published: true).where('end_date >= ?', Date.today).order(end_date: :asc)
          @selected_post_ids = params[:selected_post_ids] || []
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

    # def email
    #   if current_user.user_role == "2"
    #     params[:post_ids].each do |post_id|
    #       post = Post.find(post_id)
    #       post.update(emailed: true)
    #     end
    #     redirect_to posts_path, notice: "Posts were successfully emailed."
    #   else
    #     redirect_to root_path
    #   end
    # end
    


    def save_post_ids
      if current_user.user_role == "0"
        @user = User.find(current_user.id)
        saved_ids = @user.saved_post_ids || []
        post_id = params[:id].to_i
        saved_ids << post_id unless saved_ids.include?(post_id)
        @user.update(saved_post_ids: saved_ids)
        redirect_to posts_path, notice: "Post was successfully saved."
      else
        redirect_to root_path
      end
    end
    
    def unsave_post_ids
      if current_user.user_role == "0"
        @user = User.find(current_user.id)
        saved_ids = @user.saved_post_ids || []
        post_id = params[:id].to_i
        saved_ids.delete(post_id)
        @user.update(saved_post_ids: saved_ids)
        redirect_to posts_path, notice: "Post was successfully unsaved."
      else
        redirect_to root_path
      end
    end


    def notifications
      # find posts that are posted after the last sign in date, check their tags and send notifications to users with at least one matching tags, notification will be a pop down with title and start date of the post and clicking on it will take the user to the show page of the post
      #  every time a user logs in, check for posts posted after the last sign in date and send notifications to users with matching tags
      #  if a user has a notification, show a bell icon on the top right corner of the page, clicking on it will show the notifications, also show the number of notifications

      # 1. find posts that are posted after the last sign in date
      # 2. check their tags
      # 3. send notifications to users with at least one matching tags
      # 4. notification will be a pop down of list of posts with title and start date of the post
      # 5. clicking on it will take the user to the show page of the post
      # 6. every time a user logs in, check for posts posted after the last sign in date and send notifications to users with matching tags
      # 7. if a user has a notification, show a bell icon on the top right corner of the page
      # 8. clicking on it will show the notifications
      # 9. also show the number of notifications


      if current_user.user_role == "0"
        @notifications = current_user.notification_ids
        for post in Post.all
          if post.created_at > current_user.last_sign_in_at
            for tag in post.tags
              if current_user.tags.include?(tag)
                @notifications += [post.id]
                @notifications = @notifications.uniq
                current_user.update(notification_ids: @notifications)
              end
            end
          end
        end
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
  