require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe UsersController do
  before(:each) { login_as :jordan }
  it 'redirects to login page when no one is logged in' do
    logout
    get :index
    response.should redirect_to(login_path)
  end
  
  it 'redirects to home page if user is not an admin' do
    logout
    login_as :bob
    get :index
    response.should redirect_to(:root)
  end
  
  it 'handles /users with GET' do
    get :index
    response.should be_success
  end
  
  it 'handles /users/:id with GET' do
    get :show, id: users(:jordan)
    response.should be_success
  end
  
  it 'handles /users with valid params and POST' do
    running {
      post :create, user: {name: 'name', password: 'passWORD'}
      response.should redirect_to(users_path)
    }.should change(User, :count).by(1)
  end
  
  it 'handles /users/:id with valid params and PUT' do
    user = users(:jordan)
    put :update, id: user.to_param, user: {name: 'new', password: 'passWORD'}
    user.reload.name.should == 'new'
    response.should redirect_to(user_path(user))
  end
  
  it 'handles /users/:id with invalid params and PUT' do
    user = users(:jordan)
    put :update, id: user, user: {name: ''}
    user.reload.name.should_not == ''
    response.should be_success
    response.should render_template(:show)
  end

  it 'forbids mass assignment of the admin flag' do
    user = users(:jordan)
    put :update, id: user, user: {name: ''}
    user.reload.name.should_not == ''
    response.should be_success
    response.should render_template(:show)
  end
  
  it 'handles /users/:id with DELETE' do
    running {
      delete :destroy, id: users(:jordan)
      response.should redirect_to(users_path)
    }.should change(User, :count).by(-1)
  end

end
