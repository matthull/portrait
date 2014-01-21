require 'spec_helper'

describe SessionsController do
  it 'creates the user session if valid credentials are supplied' do
    post :create, credentials: {name: 'jordan', password: 'passWORD'}
    user = User.where(name: 'jordan').first
    session[:user].should be(user.id)
  end

  it 'redirects to root when valid credentials are supplied' do
    post :create, credentials: {name: 'jordan', password: 'passWORD'}
    response.should redirect_to(root_path)
  end

  it 'shows the login form when valid credentials are not supplied' do
    post :create, credentials: {name: 'santaclaus', password: 'passWORD'}
    response.should render_template('new')
  end

  it 'unsets the session user on logout' do
    post :create, credentials: {name: 'jordan', password: 'passWORD'}
    delete :destroy
    session.should_not have_key(:user)
  end
end
