class BooksController < ApplicationController
def index
		@books = Book.all
	end
	
	def show
		@book = Book.find(params[:id])
	end
	
	def new
		@book = Book.new
		respond_to do |format|
			format.html do
				@books = Book.all
				redirect_to books_path
			end
			format.js
		end
	end
	
	def edit
		@book = Book.find(params[:id])
		respond_to do |format|
			format.html do
				@books = Book.all
				redirect_to books_path
			end
			format.js
		end
	end
	
	def create
		@book = Book.new(book_params)
		@book.isbn.delete!("-")
		@book.save
		
		respond_to do |format|
			format.js
		end
	end
	
	def update
		@book = Book.find(params[:id])
		params[:isbn].delete!("-")
		
		@book.update(book_params)
		respond_to do |format|
			format.js
		end	
	end
	
	def destroy
		@book = Book.find(params[:id])
		@book.destroy
		@old_id = params[:id]
		
		respond_to do |format|
			format.js
		end
	end
	
	def librarylist
		@book = Book.find(params[:id])
		@libraries = Library.find_by_sql("SELECT * FROM libraries l WHERE NOT EXISTS( SELECT 1 FROM catalogs c WHERE l.id == c.library_id AND c.book_id == #{@book.id})")
		
		respond_to do |format|
			format.js
		end
	end
	
	def libraryadd
		@book = Book.find(params[:id])
		if params[:library_ids]
			@libraries = Library.find(params[:library_ids])
		else
			@libraries = []
		end
		
		@book.libraries << @libraries
		
		@libraries.each do |library|
			catalogentry = Catalog.find_by book_id: @book.id, library_id: library.id
			catalogentry.search_count = 0
			catalogentry.save
		end
		
		respond_to do |format|
			format.js
		end
	end
	
	def librarydestroy
		@book = Book.find(params[:id])
		@library = Library.find(params[:libraryid])
		@book.libraries.delete(@library)
		
		respond_to do |format|
			format.js
		end
	end
	
	private
		def book_params
			params.require(:book).permit(:title, :isbn)
		end
end
