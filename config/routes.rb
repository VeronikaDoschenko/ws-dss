Rails.application.routes.draw do
  # This line mounts Refinery's routes at the root of your application.
  # This means, any requests to the root URL of your application will go to Refinery::PagesController#home.
  # If you would like to change where this extension is mounted, simply change the
  # configuration option `mounted_path` to something different in config/initializers/refinery/core.rb
  #
  # We ask that you don't use the :as option here, as Refinery relies on it being the default of "refinery"
  mount Refinery::Core::Engine, at: Refinery::Core.mounted_path
  
  resources :locales do
    resources :translations, constraints: { :id => /[^\/]+/ }
  end

  resources :ws_set_model_runs
  resources :ws_param_values
  resources :ws_model_runs
  get 'ws_model_runs/:id/ranking' => 'ws_model_runs#ranking', as: :show_model_runs_ranking
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
  get  'students_export' => 'students#export'
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
    resources :ws_jobs do
      member do
        get  :file_form
        patch :file_save
        get  :show_content
      end
    end

    #get 'ws_jobs/:id/file_form' => 'ws_jobs#file_form', as: :file_form_ws_job
    #put 'ws_jobs/:id/file_save' => 'ws_jobs#file_save', as: :file_save_ws_job
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
