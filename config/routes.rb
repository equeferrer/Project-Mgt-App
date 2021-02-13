Rails.application.routes.draw do

  # resources :categories do
  #   resources :tasks
  # end

  resources :projects, shallow: true do
    resources :categories do
      resources :tasks
    end
  end
  
end
