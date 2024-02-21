class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # Disabling caching will prevent sensitive information being stored in the
  # browser cache. If your app does not deal with sensitive information then it
  # may be worth enabling caching for performance.
  before_action :set_current_user
  before_action :update_headers_to_disable_caching

  def set_current_user
    if session[:user_id]
      Current.user = User.find(session[:user_id])
    end
  end

  private
  def require_login
    unless user_signed_in?
      redirect_to new_user_session_path
    end
  end
  


  private
    def update_headers_to_disable_caching
      response.headers['Cache-Control'] = 'no-cache, no-cache="set-cookie", no-store, private, proxy-revalidate'
      response.headers['Pragma'] = 'no-cache'
      response.headers['Expires'] = '-1'
    end
end
