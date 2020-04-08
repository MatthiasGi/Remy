Rails.application.routes.draw do
  resources :recipes, only: [:index, :show]
  get '/recipes/:id/cook', to: 'recipes#cook', as: 'recipecook'
end
