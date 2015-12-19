Rails.application.routes.draw do
  get 'notifications/edit_notify'
  get 'notifications/see_all_notify'
  get 'notifications/edit'
  get 'notifications/modify'
  get 'notifications/delete'
  get 'notifications/add'
  get 'notifications/create'
  get 'notifications/display'
  get 'userpasswordchange/change'
get 'userpasswordchange/change_pwd'
get 'expense_details/forcast_expense'
get 'user_profile/calculate_forecast_expense'
get 'user_profile/calculate_forecost_expense'

  get 'sessions/create'

  get 'sessions/destroy'

  get 'home/show'

  get 'user_profile/home_page'

  get 'edit_expense/edit'
  get 'edit_expense/modify'
  get 'edit_expense/delete'
  get 'about/display_about'
  
  get 'user_register/add_user'
   get 'user_register/add_user_fb'
   get 'user_register/hello'
  get 'user_register/new_user'

  get 'shared_expense/share_expense'
  
  get 'transactions/get_by_date'

  get 'transactions/get_by_type'

  get 'transactions/get_by_amount'
  
  get 'transactions/select_transaction_type'
  get 'transactions/select_by_date'
  get 'transactions/select_by_type'
  get 'transactions/select_by_amount'

  get 'expense_details/fill_expense'
  get 'expense_details/add_expense'
 get 'expense_details/get_expense_types'
  get 'user_login/auth_user'
  get 'user_login/auth_user_fb'
  get  'omniauth_callbacks/twitter'
  get 'user_reg/add'

  get 'welcome/index'
  get 'welcome/add'
	
  match "user_login/auth_user" => "user_login#auth_user", :via => :post
  match "expense_details/forcast_expense" => "expense_details#forcast_expense", :via => :post
  match "expense_details/add_expense" => "expense_details#add_expense", :via => :post
  
  match "expense_details/fill_expense" => "expense_details#fill_expense", :via => :post
  
  match "transactions/get_by_date" => "transactions#get_by_date", :via => :post
  
  match "transactions/get_by_type" => "transactions#get_by_type", :via => :post
  
  match "transactions/get_by_amount" => "transactions#get_by_amount", :via => :post
  
  match "user_register/add_user" => "user_register#add_user", :via => :post
  
  match "user_register/new_user" => "user_register#new_user", :via => :post
  
  match "welcome/index" => "welcome#index", :via => :delete
  
  match "edit_expense/edit" => "edit_expense#edit", :via => :post
  
  match "edit_expense/modify" => "edit_expense#modify", :via => :post
  
  match "edit_expense/delete" => "edit_expense#delete", :via => :post
  match "user_profile/home_page" =>"user_profile#home_page", :via => :post

  match "userpasswordchange/change_pwd" =>"userpasswordchange#change_pwd", :via => :post
  match "addnotification/update" =>"addnotification#update",:via => :post
  match "notifications/see_all_notify" =>"notifications#see_all_notify", :via => :post
  match "notifications/edit" =>"notifications#edit", :via => :post
  match "notifications/modify" =>"notifications#modify", :via => :post
  match "notifications/delete" =>"notifications#delete", :via => :post
  match "notifications/add" =>"notifications#add", :via => :post
  match "notifications/display" =>"notifications#display", :via => :post
  match "notifications/create" =>"notifications#create", :via => :post
  match "user_login/change_pwd" =>"user_login#change_pwd", :via => :post


  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'welcome#index'

devise_for :UserDetail, :controllers => { :omniauth_callbacks => "omniauth_callbacks" }
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
