require 'api_constraints'

Rails.application.routes.draw do

    scope module: :api do
      scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do
        resources :users
        resources :sessions, :only => :create
      end
    end

end
