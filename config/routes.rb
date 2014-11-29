Rails.application.routes.draw do
  # show current modules of each patient by timeframe
  get '/admin/patient/:id', to: 'doctors#info'

  # add existing modules to a patient
  get '/admin/patient/:id/module/new', to: 'patient#edit'

  get '/admin/module/new', to: 'treatment_modules#new'
  post '/admin/module/new', to: 'treatment_modules#create'

  devise_for :patients
  resources :patients
end
