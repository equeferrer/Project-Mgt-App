Rails.application.routes.draw do

  devise_for :users
  root 'home#index'
  get 'home/index'
  # resources :categories do
  #   resources :tasks
  # end

  resources :projects, shallow: true do
    resources :categories do
      resources :tasks
    end
  end
  
end
