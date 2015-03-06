class Catalog < ActiveRecord::Base
	belongs_to :libraries
	belongs_to :books
end
