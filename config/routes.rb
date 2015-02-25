Rails.application.routes.draw do
  get 'categories/show'

  devise_for :doctors
  devise_for :patients

  root 'home#index'

  # show current modules of each patient by timeframe
  get '/admin/patient/:id', to: 'doctors#info'

  # add existing modules to a patient
  get '/admin/patient/:id/module/new', to: 'patient#edit'

  get '/admin/teams', to: 'team#index', as: 'teams'
  get '/admin/teams/:id', to: 'team#show', as: 'team'
  delete '/admin/teams/:id', to: 'team#remove'
  post '/admin/teams/:id', to: 'team#add'
  delete 'admin/teams', to: 'team#destroy'

  get '/admin/state/:id', to: 'treatment_states#edit'
  get '/admin/state/:id/:category_id', to: 'treatment_states#edit'
  get '/admin/state/:id/:category_id/:subcategory_id', to: 'treatment_states#edit'

  get '/admin/module/new/cat/:id', to: 'data_modules#new', as: :data_module_cat
  get '/admin/module/:id', to: 'data_modules#show'
  get '/admin/categories/edit', to: 'categories#edit', as: :edit_categories

  resources :patients
  resources :treatment_modules

  resources :subcategories, only: [:update, :show]

  resources :data_modules

  resources :categories do
    resources :subcategories, only: [:new, :create, :index]
    resources :data_modules, only: [:new, :create]
    resources :treatment_states, only: [:show, :index]
  end

  resources :treatment_states, only: [:edit, :update, :create, :new]

  namespace :admin do

  end

end
