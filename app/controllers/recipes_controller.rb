class RecipesController < ApplicationController
  def index
    @recipes = Recipe.all
  end

  def show
    @recipes = Recipe.all
    @recipe = Recipe.find_by(id: params[:id]) or redirect_to recipes_url
  end

  def cook
    @recipe = Recipe.find_by(id: params[:id]) or return redirect_to recipes_url
    @url_back = recipe_url(@recipe)
    @url_forward = recipe_step_url(@recipe, 1)
  end

  def step
    @recipe = Recipe.find_by(id: params[:id]) or return redirect_to recipes_url
    @step_number = params[:step].to_i
    if @step_number < 1 or @step_number > @recipe.steps.count
      return redirect_to recipe_url(@recipe)
    end
    @step = @recipe.steps.order(:number)[@step_number - 1]

    if @step_number > 1
      @url_back = recipe_step_url(@recipe, @step_number - 1)
    else
      @url_back = recipe_cook_url(@recipe)
    end
    if @step_number < @recipe.steps.count
      @url_forward = recipe_step_url(@recipe, @step_number + 1)
    else
      @url_forward = recipes_url
    end
  end
end
