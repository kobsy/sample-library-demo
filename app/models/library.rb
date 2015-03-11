class Library < ActiveRecord::Base
	has_many :catalogs
	has_many :books, through: :catalogs
	
	validates :name, :location, presence: true
end
