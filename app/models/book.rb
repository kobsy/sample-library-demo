class Book < ActiveRecord::Base
	has_many :catalogs
	has_many :libraries, through: :catalogs
end
