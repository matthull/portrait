class SessionsController < ApplicationController
  skip_before_filter :user_required

  def create
    credentials = params[:credentials]
    user = User.authenticate(credentials[:name], credentials[:password])
    if user
      session[:user] = user.id
      flash[:notice] = 'Successfully logged in'
      redirect_to :root, notice: 'Successfully logged in'
    else
      flash.now[:error] = 'Invalid username or password!'
      render 'new'
    end
  end

  def destroy
    session.delete :user
    redirect_to new_session_path, notice: 'Logged out'
  end
end
