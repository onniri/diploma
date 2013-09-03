AnnDiploma::Application.routes.draw do
  resources :tags, :only => [:show,:index,:destroy]
  put '/walls/:id/new_message', :action => :new_message, :controller => :walls, :as => :new_wall_message, :constraints => {:id => /\d+/}
  get '/interests/completion(/:query)', :action => 'completion_index', :controller => 'interests', :as => :interests_completion
  resources :interests do
    get :want, :action => 'want'
    get :can, :action => 'can'
    get :dont_want, :action => 'dont_want'
    get :cannot, :action => 'cannot'
  end
  resources :groups do
    get :users, :action => 'group_users'
    get :leave, :action => 'leave'
    get :join, :action => 'join'
  end
  resources :users do
    resources :conversations, :only => [:new,:show,:index]
    get :groups, :controller => 'groups', :action => 'user_groups'
    resources :interests, :only => [:index,:show] do
      get :index, :action => 'interests#user_interests'
      get :show, :action => 'interests#user_interest'
    end
    get :search, :on => :collection
  end
  resources :conversations, :only => [] do
    resources :messages, :only => [:create]
  end
  #root :to => 'StaticPages#welcome'
  root :to => 'static_pages#welcome'
  get '/help' => 'static_pages#help'
  get '/about' => 'static_pages#about'
  get '/signin' => 'sessions#new'
  post '/signin' => 'sessions#create'
  delete '/signout' => 'sessions#destroy'
  get '/signup' => 'users#new'
  scope '/locations', :as => 'locations' do
    get 'countries(/:lang)' => 'locations#list_countries', :as => 'countries'
    get 'cities/:iso_2letters(/:query)(/:lang)' => 'locations#list_cities', :as => 'cities'
  end
end
