Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :employees do
    member do
      post 'present', to: 'employees#present'
      post 'absent', to: 'employees#absent'
    end
  end
  post '/attendances/today', to: 'attendances#today'
  resources :attendances do
  end
  resources :holidays

  get '/service-worker.js' => "pages#service_worker"
  get '/manifest.json' => "pages#manifest"
  root 'pages#dashboard'
end
