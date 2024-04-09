# app/controllers/email_drafts_controller.rb
class EmailDraftsController < ApplicationController
    def new
      @selected_posts = Post.where(id: params[:selected_post_ids])
      # print @selected_posts
      flash[:alert] = "You can select up to 10 posts." if @selected_posts.size > 0
      flash[:alert] = "You must select at least one post." if @selected_posts.size == 0
      @default_text = generate_default_text(@selected_posts)
      if @selected_posts.size > 0 
          params[:selected_post_ids].each do |post_id|
          post = Post.find(post_id)
          post.update(emailed: true)
        end
      end
    end

    def add_selected_post_ids
      @post = Post.find(params[:post_id])
      @selected_post_ids = params[:selected_post_ids] || []
      if !@selected_post_ids.include?(@post.id)
        @selected_post_ids << @post.id
      end
      redirect_to posts_path(visibility: 'email', selected_post_ids: @selected_post_ids)
    end

    def remove_selected_post_ids
      @post = Post.find(params[:post_id])
      @selected_post_ids = params[:selected_post_ids] || []
      if @selected_post_ids.include?(@post.id)
        @selected_post_ids.delete(@post.id)
      end
      redirect_to posts_path(visibility: 'email', selected_post_ids: @selected_post_ids)
    end
  
    private
  
    def generate_default_text(posts)
      default_text = "Hello,\n\nHere are some new opportunities in the department of computer science:\n\n"
      posts.each do |post|
        @post = Post.find(post.id)
        default_text += "- #{@post.title}, starting on #{@post.start_date.strftime('%B %d, %Y')}, URL: #{@post.url}\n"
      end
      default_text += "\nBest regards,\ncom_opportunities"
    end

    def email_draft_params
      params.require(:email_draft).permit!
    end
  end
  