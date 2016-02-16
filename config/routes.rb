Rails.application.routes.draw do
  #get 'posts/index'

  #get 'posts/show'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :admins, controllers: {sessions: 'admin/sessions'},
   :path_names => { :sign_in => "login", :sign_out => "logout" } 

  # Serve websocket cable requests in-process
  # mount ActionCable.server => '/cable'
  root 'home#index'

  resources :posts, only: [:index, :show]

  namespace :admin do
    get 'dashboard' => 'dashboard#index'
    resources :admins, except: [:show]
    resources :posts
  end
end
