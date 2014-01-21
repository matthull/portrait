class UsersController < ApplicationController
  
  # GET /users
  def index
    @users = User.order('name')
    @user  = User.new
  end
  
  # GET /users/:id
  def show
    @user = User.find_by_name! params[:id]
  end
  
  # POST /user
  def create
    @user = User.new user_params
    @user.save!
    redirect_to users_url
  rescue ActiveRecord::RecordInvalid
    @users = User.order('name')
    render action: 'index'
  end
  
  # PUT /users/:id
  def update
    @user = User.find_by_name! params[:id]
    @user.update_attributes! user_params
    redirect_to @user
  rescue ActiveRecord::RecordInvalid
    render action: 'show'
  end
  
  # DELETE /users/:id
  def destroy
    @user = User.find_by_name! params[:id]
    @user.destroy
    redirect_to users_url
  end

  private

  def user_params
    params.require(:user).permit!
  end
  
end
