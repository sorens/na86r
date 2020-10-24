NA86::Application.routes.draw do
  ActiveAdmin.routes(self)
  devise_for :admin_users, ActiveAdmin::Devise.config

  devise_for :users, :controllers => { :sessions => 'sessions', :registrations => 'beta' }, :path_names => { :sign_up => 'register', :sign_in => 'login', :sign_out => 'logout' }, :skip => :sessions
  devise_scope :user do
    get    'register'  => 'beta#new',          :as => :new_user_registration
    post   'register'  => 'beta#create',       :as => :user_registration
    get    'login'     => "sessions#new",      :as => :new_user_session
    post   'login'     => 'sessions#create',   :as => :user_session
    get    'logout'    => 'sessions#destroy',  :as => :destroy_user_session
  end

  get "welcome/index"
  root :to => "welcome#index"
end
