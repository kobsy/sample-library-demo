Rails.application.routes.draw do
  # get 'welcome/index'

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

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  #	root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
