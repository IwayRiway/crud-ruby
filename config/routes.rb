Rails.application.routes.draw do
  root 'home#index'

  get 'home/index'
  get 'home/about'

  resources :friends

  get 'postingan/index'
  get 'postingan/detail/:id', to: 'postingan#detail'
  get 'postingan/input', to: 'postingan#input'
  post 'postingan/create', to: 'postingan#create'
  get 'postingan/edit/:id', to: 'postingan#edit'
  post 'postingan/update/:id', to: 'postingan#update'
  get 'postingan/delete/:id', to: 'postingan#delete'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
