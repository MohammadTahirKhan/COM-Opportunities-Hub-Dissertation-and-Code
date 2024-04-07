class AdminController < ApplicationController
  def index
    @posts= Post.where(published: false)
  end

    def show
    end

    def edit
    end

    def destroy
        @post.destroy
        redirect_to admin_index_path, notice: "Post was successfully deleted."
    end

    def approve
        @post = Post.find(params[:id])
        @post.update(published: true)
        redirect_to admin_index_path, notice: "Post was successfully approved."
    end

    def update
        if @post.update(post_params)
            redirect_to admin_index_path, notice: "Post was successfully updated."
        else
            render :edit, status: :unprocessable_entity
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