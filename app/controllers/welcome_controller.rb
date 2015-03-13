class WelcomeController < ApplicationController
	def index
  		@libraries = Library.all.order(name: :asc)
  		# Add a paramater so that we can keep our selected library selected if we go
  		# back from search results.
  		@libraryid = ''
  		if params.has_key?(:libraryid)
  			@libraryid = params[:libraryid]
  		end
	end
	
	def search
		@library = Library.find(params[:libraryid])
		@term = params[:search]
		isbn_search = ''
		query_str = ''
		query_array = []
		unless /\d{10}|\d{3}-\d{10}|\d{13}/.match(@term).nil?
			# This is probably an ISBN Number. Search the ISBN field, as well as
			# the title field (after all, it's conceivable that a book has a title
			# that's 10 or 13 digits in a row, however unlikely it may be in practice).
			isbn_search = @term.delete("-") # Remove any dashes for a standard format to search
			query_str += "isbn = ? "
			query_array << isbn_search
		end
		
		# Assuming a title, we'll break up the title into words and search for each of them in an
		# OR construction. This will hopefully get us more matches, even if they
		# get a word wrong or out-of-order.
		
		# If we're divvying it up into words, we'll also be disregarding the punctuation
		@term_array = @term.delete('.,"\':;]}\\|[{!?@#$%\^&*()\-_=+/<>~`').split
		
		# Build our big, hairy WHERE condition for our SQL
		@term_array.each_with_index do |term, i|
			unless i == 0 and isbn_search.empty?
				query_str += "OR "
			end
			query_str += "LOWER(title) LIKE ? "
			query_array << '%' + term.downcase + '%'
		end
		
		final_query = [ query_str, query_array ].flatten
		
		@books = Book.where(final_query).order(title: :asc)
		
		# Is this the functionality desired for the search_count counter?
		# Each match's search_count will be incremented, no matter how trivial the match.
		@books.each do |book|
			book.catalogs.each do |catalog|
				if catalog.library_id == @library.id
					catalog.search_count += 1
					catalog.save
				end
			end
		end
		
	end
end
