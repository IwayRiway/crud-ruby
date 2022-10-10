Rails.application.routes.draw do
  resources :menus

  post 'user/create', to: 'user#create'
  get 'user/manage/:id', to: 'user#manage'
  get 'user/index'

  devise_for :users

  post 'product_receivings/get_data', to: 'product_receivings#get_data'
  resources :product_receivings

  resources :products
  resources :todo_lists

  get 'home/index'
  get 'home/about'
  get 'home/test'

  resources :friends

  get 'postingan/index'
  get 'postingan/detail/:id', to: 'postingan#detail'
  get 'postingan/input', to: 'postingan#input'
  post 'postingan/create', to: 'postingan#create'
  get 'postingan/edit/:id', to: 'postingan#edit'
  post 'postingan/update/:id', to: 'postingan#update'
  get 'postingan/delete/:id', to: 'postingan#delete'

#   devise_scope :user do
#     root to: "devise/sessions#new"
#   end  

  root 'home#index'
#   root new_user_session_path
end
