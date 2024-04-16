class ProfileController < ApplicationController

    before_action :authenticate_user!
    def index
        @user = current_user
    end

    def show
        @user = current_user
    end

    def edit
        @user = current_user
    end

    def update
        @user = current_user
        if @user.update(full_name: params[:user][:full_name], email: params[:user][:email], password: params[:user][:password], password_confirmation: params[:user][:password_confirmation], tags: params[:user][:tags])
            redirect_to profile_path, notice: "Profile was successfully updated."
        else
            if User.find_by(email: params[:user][:email]).present? && User.find_by(email: params[:user][:email]).id != @user.id 
                flash[:alert] = "Email has already been taken"
            end
            render :edit, status: :unprocessable_entity
        end
    end

    def destroy
        @user = current_user
        unless @user.user_role == "2"
            @user.destroy
            redirect_to root_path
        end
    end

    private

    def user_params
        params.require(:user).permit!
    end


end