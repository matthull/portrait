class ApplicationController < ActionController::Base
  before_filter :current_user, :admin_required

  protected
  def admin_required
    unless current_user && current_user.admin?
      redirect_to new_session_path
    end
  end

  def user_required
    unless current_user
      redirect_to new_session_path
    end
  end

  def current_user
    if session[:user]
      @current_user = User.find(session[:user])
    end
  end
end
