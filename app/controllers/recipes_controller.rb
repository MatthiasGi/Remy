class RecipesController < ApplicationController
  before_action :get_recipes, only: [:index, :show]
  before_action :get_recipe, only: [:show, :cook, :step]

  def index; end

  def show; end

  def cook
    @meta = {
      'url_back': recipe_url(@recipe),
      'url_forward': recipe_step_url(@recipe, 1)
    }
  end

  def step
    @recipe = Recipe.find_by(id: params[:id]) or return redirect_to recipes_url

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

  private

  def get_recipes
    @recipes = Recipe.all
  end

  def get_recipe
    @recipe = Recipe.find_by(id: params[:id]) or redirect_to recipes_url
  end
end
