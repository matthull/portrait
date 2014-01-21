class User < ActiveRecord::Base

  attr_reader :password
  def password=(password)
    @password = password
    self.password_hash = BCrypt::Password.create(password)
  end

  def self.authenticate(name, password)
    user = User.where(name: name).first
    if user && BCrypt::Password.new(user.password_hash) == password
      user
    end
  end

  has_many :sites, :dependent=>:destroy

  def to_param() name end

  validates :password_hash, presence: true
  validates :password, length: {within: 6..32}, on: :create
  validates :password, format: {with: /.*[A-Z].*/, message: 'must have at least one upper case character'}, on: :create
  validates :password, format: {with: /.*[a-z].*/, message: 'must have at least one lower case character'}, on: :create
  validates :name, uniqueness: true, format: /[a-z0-9]+/
end
