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
        if @user.update(user_params)
            redirect_to profile_path, notice: "Profile was successfully updated."
        else
            render :edit, status: :unprocessable_entity
        end
    end


end