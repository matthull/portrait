class User < ActiveRecord::Base

  attr_reader :password
  def password=(password)
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
  validates :name, uniqueness: true, format: /[a-z0-9]+/
end
