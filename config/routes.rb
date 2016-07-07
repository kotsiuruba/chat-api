require 'api_constraints'

Rails.application.routes.draw do

    scope module: :api do
      scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do
        resources :users
        resources :sessions, :only => :create
        resources :chats, :only => [:index, :create, :update, :show] do
          member do
            patch 'read'
          end

          match '/messages/new' => 'messages#new', :via => :get
          resources :messages, :only => [:create, :index]
        end
      end
    end

end
