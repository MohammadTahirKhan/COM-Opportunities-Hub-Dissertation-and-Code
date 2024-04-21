# # spec/controllers/sessions_controller_spec.rb
# require 'rails_helper'

# RSpec.describe SessionsController, type: :controller do
#   describe 'POST #create' do
#     let(:user) { create(:user, email: 'test@example.com', password: 'password') }

#     context 'with valid credentials' do
#       it 'logs in the user and redirects to root_path' do
#         post :create, params: { email: user.email, password: 'password' }
#         expect(session[:user_id]).to eq(user.id)
#         expect(response).to redirect_to(root_path)
#         expect(flash[:notice]).to eq('Logged in!')
#       end
#     end

#     context 'with invalid credentials' do
#       it 'redirects to new_session_path with an error message' do
#         post :create, params: { email: 'invalid@example.com', password: 'invalid_password' }
#         expect(session[:user_id]).to be_nil
#         expect(response).to redirect_to(new_session_path)
#         expect(flash[:alert]).to eq('Email or password is invalid')
#       end
#     end
#   end

#   describe 'DELETE #destroy' do
#     let(:user) { create(:user) }

#     before { session[:user_id] = user.id }

#     it 'logs out the user and redirects to root_path' do
#       delete :destroy
#       expect(session[:user_id]).to be_nil
#       expect(response).to redirect_to(root_path)
#       expect(flash[:notice]).to eq('Logged out successfully')
#     end
#   end
# end
