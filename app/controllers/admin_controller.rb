class AdminController < ApplicationController
  before_action :authenticate_user!
  before_action :require_admin

  def require_admin
    unless current_user.user_role == "2"
      redirect_to root_path
    end
  end

  def index
    if params[:view] == "users"
      @users = User.all
    else
      redirect_to root_path
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    user = User.find(params[:id])
    user_params = params.require(:user).permit(:user_role)
    user.update(user_params)
    redirect_to admin_index_path
  end
    
end