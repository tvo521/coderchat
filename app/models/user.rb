class User < ActiveRecord::Base
  has_secure_password

  has_many :messages

  validates :name, :email, presence: true
end
