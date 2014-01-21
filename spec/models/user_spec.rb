require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe User, 'authentication' do
  it 'should authenticate a valid user' do
    User.authenticate('jordan', 'passWORD').should == users(:jordan)
  end
  
  it 'should not authenticate valid user with wrong password' do
    User.authenticate('jordan', 'wrong').should be_nil
  end
  
  it 'should not authenticate valid user with nil password' do
    User.authenticate('jordan', nil).should be_nil
  end
  
  it 'should not authenticate with invalid user name' do
    User.authenticate('invalid', 'anything').should be_nil
  end
  
  it 'should not authenticate with nil user name' do
    User.authenticate(nil, nil).should be_nil
  end
end

describe User, 'validations' do
  it 'should have a name' do
    User.new.should have(1).error_on(:name)
  end
  
  it 'should have a name with valid characters' do
    User.new(name: 'INVALID').should have(1).error_on(:name)
  end

  it 'should have a password with at least 6 characters' do
    User.new(password: 'aaBBB') .should have(1).error_on(:password)
  end

  it 'should have a password with at most 32 characters' do
    User.new(password: ('a' * 16) + ('B' * 17)).should have(1).error_on(:password)
  end

  it 'should have at least one capital letter in password' do
    User.new(password: 'lowercase').should have(1).error_on(:password)
  end

  it 'should have at least one lower case letter in password' do
    User.new(password: 'UPPERCASE').should have(1).error_on(:password)
  end
  
  it 'should have a password hash' do
    User.new.should have(1).error_on(:password_hash)
  end
  
  it 'should have a unique name' do
    User.new(name: users('jordan').name).should have(1).error_on(:name)
  end
end
