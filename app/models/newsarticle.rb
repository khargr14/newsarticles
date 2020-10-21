class Newsarticle < ActiveRecord::Base
	belongs_to :user

	validates :title, presence: true, length: { minimum: 2 }
	validates :text, presence: true, length: { minimum: 2 }
	validates :author, presence: true, length: { minimum: 3 }
end