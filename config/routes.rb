Rails.application.routes.draw do
  devise_for :doctors
  devise_for :patients

  root 'home#index'

  # show current modules of each patient by timeframe
  get '/admin/patient/:id', to: 'doctors#info'

  # add existing modules to a patient
  get '/admin/patient/:id/module/new', to: 'patient#edit'

  get '/admin/module/new', to: 'treatment_modules#new'
  post '/admin/module/new', to: 'treatment_modules#create'

  get '/treatments/all', to: 'treatment_modules#all'

  resources :patients
  resources :treatment_modules
end
