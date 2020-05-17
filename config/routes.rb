Rails.application.routes.draw do
  root to: 'recipes#index'

  # Nutzerseitige Anzeige von Rezepten
  resources :recipes, only: [:index, :show]
  get '/recipes/:id/cook', to: 'recipes#cook', as: 'recipe_cook'
  get '/recipes/:id/cook/:step', to: 'recipes#step', as: 'recipe_step', constraints: { step: /\d+/ }

  # Administrationsoberfläche
  namespace :admin do
    resources :recipes, except: :show
  end
end
