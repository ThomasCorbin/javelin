Javelin::Application.routes.draw do

  resources :users do
    resources :microposts, :only => [:index]
  end

  resources :sessions,    :only => [:new, :create, :destroy]
  resources :microposts,  :only => [:create, :destroy]

  match '/contact',       :to => 'pages#contact'
  match '/about',         :to => 'pages#about'
  match '/help',          :to => 'pages#help'
  match '/signup',        :to => 'users#new'
  match '/signin',        :to => 'sessions#new'
  match '/signout',       :to => 'sessions#destroy'

 # get "pages/home"
 # get "pages/about"
 # get "pages/contact"

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => "welcome#index"
  root :to => 'pages#home'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
