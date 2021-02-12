Rails.application.routes.draw do

  # resources :categories

  resources :categories do
    resources :tasks
  end

end
