class User < ActiveRecord::Base
  include BCrypt
	has_many :newsarticles
	has_secure_password

	validates :name, presence: true, length: { minimum: 2 }
	validates :lastname, presence: true, length: { minimum: 2 }
	validates :email, presence: true, length: { minimum: 3 }
  validates :password, presence: true, length: { minimum: 6 }
	validates_uniqueness_of :email


end