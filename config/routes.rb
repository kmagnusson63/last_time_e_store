LastTimeEStore::Application.routes.draw do
  root :to => 'store#index', :via => :get
  #get "store/index"
  

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  match 'confirm_order' => 'store#confirm_order', :as => 'confirm_order', :via => :post 
  match 'del_from_shopping_cart' => 'store#del_from_shopping_cart', :as => 'del_from_shopping_cart', :via => :post

  match 'add_to_shopping_cart' => 'store#add_to_shopping_cart', :as => 'add_to_shopping_cart', :via => :post
  match 'single_checkout' => 'store#single_checkout', :as => 'single_checkout', :via => :post
  
  match 'shopping_cart' => 'store#shopping_cart', :as => 'shopping_cart', :via => :get
  match 'search_results' => 'store#search_results', :as => 'search_results', :via => [:get, :post]
  match 'confirm_shopping_cart' => 'store#confirm_shopping_cart', :as => 'confirm_shopping_cart', :via => [:get,:post]
  match '*permalk' => 'nav_bar#index', :via => :get
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  

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
