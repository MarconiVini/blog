Rails.application.routes.draw do

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
