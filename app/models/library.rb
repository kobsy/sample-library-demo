class Library < ActiveRecord::Base
	has_many :catalogs
	has_many :books, through: :catalogs
end
