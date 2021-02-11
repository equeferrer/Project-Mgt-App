Rails.application.routes.draw do
  # Categories
  get '/categories' => 'categories#index', as:  'categories'
  get '/categories/new' => 'categories#new', as: 'new_category' 
  post '/categories' => 'categories#create', as: 'create_category'
  get '/categories/:id/edit' => 'categories#edit', as: 'category_edit'
  patch '/categories/:id/edit' => 'categories#update', as:'category_update'
  delete '/categories/:id' => 'categories#destroy', as: 'category_delete'

end
