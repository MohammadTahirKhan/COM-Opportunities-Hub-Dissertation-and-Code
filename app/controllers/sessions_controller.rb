class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      User.update(user.id, last_sign_in_at: Time.now)
      redirect_to root_path, notice: "Logged in!"
    else
      flash[:alert] = "Email or password is invalid"
      redirect_to new_session_path
    end
  end
  
  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "Logged out successfully"
  end

  def new_registration
    @user = User.new
  end
  
  # def create_registration
  #   @user = User.new(user_params)
  #   if @user.save
  #     session[:user_id] = @user.id
  #     redirect_to root_path, notice: "Registration successful!"
  #   else
  #     flash[:alert] = "Failed to register user"
  #     render "new_registration"
  #   end
  # end

  private

  def user_params
    params.require(:user).permit(:email, :full_name, :password, :password_confirmation)
  end
end
