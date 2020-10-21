class User < ActiveRecord::Base
	has_many :newsarticles

	validates :name, presence: true, length: { minimum: 2 }
	validates :lastname, presence: true, length: { minimum: 2 }
	validates :email, presence: true, length: { minimum: 3 }
    validates :password, presence: true, length: { minimum: 6 }
    
end