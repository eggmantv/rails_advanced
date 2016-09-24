Rails.application.routes.draw do

  get 'messages/index'

  get 'messages/new'

  root 'welcome#index'

  resources :users do
    get :blogs, on: :member
    post :add_friend, on: :collection
    get :friends, on: :collection
  end
  
  resources :sessions

  resources :blogs
  resources :messages

  namespace :admin do
    root 'users#index'

    resources :users do
      collection do
        get :search
      end
    end
  end

end
