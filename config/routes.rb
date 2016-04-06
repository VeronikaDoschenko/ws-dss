Rails.application.routes.draw do
  resources :ws_model_runs
  resources :ws_model_statuses
  resources :ws_params
  resources :ws_models
  get 'edu' => 'edu#index', as: 'edu_index'
  resources :documents
  get 'documents/:id/show_content' => 'documents#show_content', as: :show_content_document
  resources :subjects
  resources :student_groups
  resources :student_groups
  resources :students
  post 'students/import' => 'students#import'
  namespace :admin do
    resources :users
  end
  get 'admin' => 'admin/admin#index'
  get 'modeling' => 'modeling#index'
  get 'persons/profile', as: 'user_root'
  get 'persons/:id/test_output' => 'persons#test_output', as: :person_test_output
  devise_for :users, controllers: { sessions: "users/sessions",
                                    registrations: "users/registrations",
                                    confirmations: "users/confirmations",
                                    passwords: "users/passwords",
                                    unlocks: "users/unlocks",
                                    sign_out:        'users/sessions#destroy'
                                  }

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  #  resource route (maps HTTP verbs to controller actions automatically):
    resources :ws_methods
    get 'ws_methods/:id/test' => 'ws_methods#test', as: :test_ws_method
    resources :ws_jobs
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
