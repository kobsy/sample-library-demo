class LibrariesController < ApplicationController
	def index
		@libraries = Library.all
	end
	
	def show
		@library = Library.find(params[:id])
	end
	
	def new
		@library = Library.new
		respond_to do |format|
			format.html do
				@libraries = Library.all
				redirect_to libraries_path
			end
			format.js
		end
	end
	
	def edit
		@library = Library.find(params[:id])
		respond_to do |format|
			format.html do
				@libraries = Library.all
				redirect_to libraries_path
			end
			format.js
		end
	end
	
	def create
		@library = Library.new(library_params)
		@library.save
		
		respond_to do |format|
			format.js
		end
	end
	
	def update
		@library = Library.find(params[:id])
		
		@library.update(library_params)
		respond_to do |format|
			format.js
		end	
	end
	
	def destroy
		@library = Library.find(params[:id])
		@library.destroy
		@old_id = params[:id]
		
		respond_to do |format|
			format.js
		end
	end
	
	def booklist
		@library = Library.find(params[:id])
		#@books = Book.joins("LEFT OUTER JOIN catalogs ON books.id = catalogs.book_id AND catalogs.library_id <> #{@library.id}")
		@books = Book.find_by_sql("SELECT * FROM books b WHERE NOT EXISTS( SELECT 1 FROM catalogs c WHERE b.id == c.book_id AND c.library_id == #{@library.id})")
		
		respond_to do |format|
			format.js
		end
	end
	
	def booklistadd
		@library = Library.find(params[:id])
		if params[:book_ids]
			@books = Book.find(params[:book_ids])
		else
			@books = []
		end
		
		@library.books << @books
		@books.each do |book|
			#catalogentry = Catalog.where("book_id = ? AND library_id = ?", book.id, @library.id)
			catalogentry = Catalog.find_by book_id: book.id, library_id: @library.id
			catalogentry.search_count = 0
			catalogentry.save
		end
		
		respond_to do |format|
			format.js
		end
	end
	
	def booklistdestroy
		@library = Library.find(params[:id])
		@book = Book.find(params[:bookid])
		@library.books.delete(@book)
		
		respond_to do |format|
			format.js
		end
	end
	
	private
		def library_params
			params.require(:library).permit(:name, :location)
		end
end
