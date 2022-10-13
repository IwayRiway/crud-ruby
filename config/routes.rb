Rails.application.routes.draw do
  resources :menus

  scope 'user' do
    get '', to: 'user#index'
    get 'index', to: 'user#index'
    get 'manage/:id', to: 'user#manage'
    post 'create', to: 'user#create'
  end

  devise_for :users

  resources :product_receivings do
    collection do
        post :get_data
    end

    member do
        get :delete
        get :pdf
        get :excel
        get :print
    end
  end
  
  resources :products do
    collection do
        post :import
    end
  end

  resources :todo_lists
  resources :friends

  scope 'postingan' do
    get '', to: 'postingan#index'
    get 'index', to: 'postingan#index'
    get 'detail/:id', to: 'postingan#detail'
    get 'input', to: 'postingan#input'
    post 'create', to: 'postingan#create'
    get 'edit/:id', to: 'postingan#edit'
    post 'update/:id', to: 'postingan#update'
    get 'delete/:id', to: 'postingan#delete'
  end

  scope 'home' do
    get '', to: 'home#index'
    get 'index', to: 'home#index'
    get 'about', to: 'home#about'
    get 'test', to: 'home#test'
  end
  
  root 'home#index'

#   devise_scope :user do
#     root to: "devise/sessions#new"
#   end  
end
