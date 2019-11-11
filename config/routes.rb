Rails.application.routes.draw do
  devise_for :users, skip: [:registrations]
  resources :representante_externos
  resources :admins
  resources :docentes
  resources :alunos

  resources :pedidos
  resources :postagems

  resources :laboratorios do
    member do
      get :busca
    end
    resources :servicos
    resources :equipamentos
  end

  get '/laboratorios/:id/vinculos', to: 'laboratorios#index_vinculos', as: 'index_vinculos'
  get '/laboratorios/:id/vinculos/vinculo', to: 'laboratorios#vinculo', as: 'new_vinculo'
  post '/laboratorios/:id/vinculos/vinculo', to: 'laboratorios#create_vinculo', as: 'create_vinculo'
  put '/laboratorios/:id/vinculos/vinculo/(:nomeCompleto)/(:nUSP)', to: 'laboratorios#remove_vinculo', as: 'remove_vinculo'
  
  get 'about_us', to: 'pages#about_us'
  get 'account', to: 'pages#account'

  root 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # root to: 'pages#home'
end
