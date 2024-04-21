# class RegistrationController < Devise::RegistrationsController
#     def new
#         @user = User.new
#     end

#     def create
#         @user = User.new(user_params)
#         if @user.save
#             session[:user_id] = @user.id
#             redirect_to root_path, notice: "Registration successful!"
#         else
#             flash[:alert] = "Failed to register user xcxc"
#             render :new
#         end
#     end

#     private

#     def user_params
#         params.require(:user).permit(:email, :full_name, :password, :password_confirmation, :user_role)
#       end
# end