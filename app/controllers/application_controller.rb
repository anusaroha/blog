class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def authenticate_user
    redirect_to new_session_path, alert: "Please sign in" unless user_signed_in?
  end

  def authorize_user
    find_article
    unless @article.user_id == current_user.id
      flash[:notice] = "You are not the creator of this article, you don't have the permissions"
      redirect_to root_path
      return false
    end
  end

  def current_user
    @current_user ||= User.find_by_id(session[:user_id])
    # @current_user ||= User.find_by_auth_token!(cookies[:auth_token]) if cookies[:auth_token]
  end
  helper_method :current_user

  def user_signed_in?
    current_user.present?
  end

  helper_method :user_signed_in?

  def sign_in(user)
    session[:user_id] = user.id
  end
end
