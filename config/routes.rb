Rails.application.routes.draw do
  resources :lottery
  # resources :charges

  post 'charges' => 'charges#create'
  get 'hjelp' => 'pages#faq'
  authenticated :user do
    root 'application#route_to_index', as: :authenticated_root
  end

  unauthenticated do
    root 'lottery#statistics'
  end

  #Devise specific
  devise_for :users, :controllers => {registrations: 'devise/custom/registrations', omniauth_callbacks: 'users/omniauth_callbacks'}
  devise_scope :user do
    get 'newcompany' => 'devise/custom/registrations#new_company'
    post 'newcompany' => 'devise/custom/registrations#create_company'
  end
  get 'statistikk' => 'lottery#statistics'
  get 'trekning/:id' => 'lottery#current_lottery', as: 'current_lottery'

  #Mypage
  get 'edit-user' => 'pages#edit_user', as: 'edit_user'
  patch 'edit-user' => 'pages#update_user'

  get 'minside' => 'pages#my_page'
  get 'kontakt' => 'pages#about', as: 'contact_us'
  post 'kontakt' => 'contactform#create'

  #Admin routes
  get 'admin' => 'admin#index'
  post 'admin' => 'admin#create'

  get 'admin/edit_lottery/:id' => 'admin#edit_lottery', as: 'admin_edit_lottery'
  patch 'admin/edit_lottery/:id' => 'admin#update'
  get 'start-trekning/:id' => 'admin#finish_lottery', as: 'admin_finish_lottery'

  get 'admin_previous_lotteries' => 'admin#previous_lotteries', as: 'admin_previous_lottery'

  patch 'admin/edit_award' => 'admin#edit_award', as: 'admin_edit_award'

  get 'admin/delete_lottery/:id' => 'admin#delete', as: 'admin_delete_lottery'

  get 'admin/edit_users' => 'admin#edit_users', as: 'admin_edit_users'

  get 'admin/edit_user/:id' => 'admin#edit_user', as: 'admin_edit_user'
  patch 'admin/edit_user/:id' => 'admin#update_user'

  get 'admin/delete_user/:id' => 'admin#delete_user', as: 'admin/delete_user'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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
