Rails.application.routes.draw do
	root 'welcome#index'
	
	post 'search', to: 'welcome#search'
	
	resources :libraries do
		member do
			get 'booklist' # New action to list books for adding to the library in question.
			post 'booklist', to: 'libraries#booklistadd' # New action to commit the adding of books to a library.
			delete 'booklist', to: 'libraries#booklistdestroy' # New action to drop a book from a library.
		end
	end
	
	resources :books do
		member do
			get 'librarylist'
			post 'librarylist', to: 'books#libraryadd'
			delete 'librarylist', to: 'books#librarydestroy'
		end
	end

end
