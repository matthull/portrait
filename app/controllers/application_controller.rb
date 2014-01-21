class ApplicationController < ActionController::Base
  before_filter :current_user, :user_required

  protected
  def admin_required
    unless current_user && current_user.admin?
      if !current_user
        redirect_to login_path
      else
        redirect_to :root, flash: {error: 'Access denied'}
      end
    end
  end

  def user_required
    if !current_user
      redirect_to login_path
    end
  end

  def current_user
    if session[:user]
      @current_user = User.find(session[:user])
    end
  end
end
