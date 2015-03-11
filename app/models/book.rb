class Book < ActiveRecord::Base
	has_many :catalogs
	has_many :libraries, through: :catalogs
	
	validates :title, presence: true
	validates :isbn, format: { with: /\d{10}|\d{3}-\d{10}|\d{13}/, message: "Use a valid ISBN-10 (##########) or ISBN-13 (###-##########) format." }
end
