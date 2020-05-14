class RecipesController < ApplicationController

  # Lädt alle Rezepte in eine Liste für Aktionen, die eine entsprechende
  # Übersicht anbieten.
  before_action :get_recipes, only: [:index, :show]

  # Lädt ein einzelnes, ausgewähltes Rezept.
  before_action :get_recipe, only: [:show, :cook, :step]

  # ============================================================================

  # Stellt alle verfügbaren Rezepte dar.
  def index; end

  # Zeigt ein ausgewähltes Rezept mit Details neben der Liste aller Rezepte.
  def show; end

  # Sobald der Nutzer sich für ein konkretes Rezept entscheidet, wird ihm
  # zunächst ein Vorschritt angezeigt, auf dem die einzelnen Zutaten noch einmal
  # aufgelistet sind.
  def cook
    @meta = {
      'url_back': recipe_url(@recipe),
      'url_forward': recipe_step_url(@recipe, 1)
    }
  end

  # Zeigt einen tatsächlich Schritt zum Kochen an.
  def step
    @recipe = Recipe.find_by(id: params[:id]) or return redirect_to recipes_url

    # Wält den i-ten Schritt aus, unabhängig von seiner tatsächlichen
    # Nummerierung, die ja eigentlich nur der Sortierung dient.
    i = params[:step].to_i
    total = @recipe.steps.count
    i.between? 1, total or return redirect_to recipe_url(@recipe)
    @meta = {'step_current': i, 'steps_total': total}

    @step = @recipe.steps.order(:number)[i-1]
    @meta[:url_back] = i > 1 ? recipe_step_url(@recipe, i - 1)
                             : recipe_cook_url(@recipe)
    @meta[:url_forward] = i < total ? recipe_step_url(@recipe, i + 1)
                                    : recipes_url
  end

  # ============================================================================

  private

  # Lädt alle verfügbaren Rezepte.
  def get_recipes
    @recipes = Recipe.all
  end

  # Lädt ein einzelnes, ausgewähltes Rezept.
  def get_recipe
    @recipe = Recipe.find_by(id: params[:id]) or redirect_to recipes_url
  end

end
