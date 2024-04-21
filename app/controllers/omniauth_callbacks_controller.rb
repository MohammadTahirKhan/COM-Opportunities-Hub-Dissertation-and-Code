# This controller is used to handle the callback from the Google OAuth2 provider.
# This will be fixed in the next sprint.


# class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    
#     def google_oauth2
#         @user = User.from_omniauth(request.env["omniauth.auth"])
#         if @user.present?
#             sign_out_all_scopes
#             flash[:success] = "Signed in with Google successfully."
#             sign_in_and_redirect @user, notice: "Signed in!"
#         else
#             flash[:alert] = 
#             t "devise.omniauth_callbacks.failure", kind: "Google", reason: "#{auth.info.email} is not authorized."
#             session["devise.user_attributes"] = @user.attributes
#             redirect_to new_user_session_path
#         end
#     end

#     private

#     def auth
#         @auth ||= request.env['omniauth.auth']
#     end
# end