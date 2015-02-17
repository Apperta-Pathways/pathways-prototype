Rails.application.routes.draw do
  mount Rich::Engine => '/rich', :as => 'rich'
  get 'categories/show'

  devise_for :doctors
  devise_for :patients

  root 'home#index'

  # show current modules of each patient by timeframe
  get '/admin/patient/:id', to: 'doctors#info'

  # add existing modules to a patient
  get '/admin/patient/:id/module/new', to: 'patient#edit'

  get '/admin/teams', to: 'team#index'
  get '/admin/teams/:id', to: 'team#show', as: 'team' 
  delete '/admin/teams/:id', to: 'team#remove'
  


  get '/admin/state/:state', to: 'treatment_states#edit'
  get '/admin/state/:state/:category', to: 'treatment_states#edit'
  get '/admin/state/:state/:category/:subcategory', to: 'treatment_states#edit'

  post '/admin/state/:state', to: 'treatment_states#update', as: :treatment_state

  get '/admin/module/new', to: 'data_modules#new'
  post '/admin/module/new', to: 'data_modules#create', as: :data_modules

  # get '/treatments/all', to: 'treatment_modules#all'



  resources :patients
  resources :treatment_modules
  resources :categories

end
