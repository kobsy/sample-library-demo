class Book < ActiveRecord::Base
	has_many :catalogs
	has_many :libraries, through: :catalogs
	
	validates :title, presence: true
	validates :isbn, format: { with: /\A\d{10}\Z|\A\d{3}-\d{10}\Z|\A\d{13}\Z/, message: "Use a valid ISBN-10 (##########) or ISBN-13 (###-##########) format." }
	
	# Put the dash back in to ISBN-13 numbers, even though they're stored without
	def isbn
		read_attribute(:isbn).length == 13 ? read_attribute(:isbn).insert(3,'-') : read_attribute(:isbn)
	end
end
