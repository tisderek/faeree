class User < ActiveRecord::Base
  include SecureRandom

	EMAIL_REGEX = /\A[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\Z/i

	validates :name, presence:true
	validates :phone, presence:true, uniqueness: true, numericality: true, length: { is: 10 }
	validates :email, presence:true, uniqueness: true, format: EMAIL_REGEX

	has_many  :events
  has_many  :contacts

end
