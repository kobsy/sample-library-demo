class Catalog < ActiveRecord::Base
	belongs_to :library
	belongs_to :book
end
