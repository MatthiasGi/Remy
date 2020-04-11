Rails.application.routes.draw do
  resources :recipes, only: [:index, :show]
  get '/recipes/:id/cook', to: 'recipes#cook', as: 'recipe_cook'
  get '/recipes/:id/cook/:step', to: 'recipes#step', as: 'recipe_step'
end
