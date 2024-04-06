class PostsController < ApplicationController
    before_action :set_posts, only: %i[ show edit update destroy ]
    before_action :require_user

  def require_user
    unless current_user.user_role == "0" || current_user.user_role == "2" || current_user.user_role == "1"
      redirect_to root_path
    end
  end
  
    # GET /posts
    def index
      @posts = Post.all
    end
  
    # GET /posts/1
    def show
    end
  
    # GET /posts/new
    def new
      @post = Post.new
    end
  
    # GET /posts/1/edit
    def edit
    end
  
    # POST /posts
    def create
      @post = Post.new(product_params)
  
      if @post.save
        redirect_to post_path, notice: "post was successfully created."
      else
        render :new, status: :unprocessable_entity
      end
    end
  
    # PATCH/PUT /posts/1
    def update
      if @post.update(post_params)
        redirect_to post_path, notice: "post was successfully updated."
      else
        render :edit, status: :unprocessable_entity
      end
    end
  
    # DELETE /posts/1
    def destroy
      @post.destroy
      redirect_to post_url, notice: "post was successfully destroyed."
    end
  
    private
      # Use callbacks to share common setup or constraints between actions.
      def set_post
        @post = Post.find(params[:id])
      end
  
      # Only allow a list of trusted parameters through.
      def post_params
        params.require(:post).permit(:title, :location, :organiser, :deadline, :description, :url, :post_type, :emailed, :tags, :recurring)
      end
  end
  