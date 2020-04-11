class RecipesController < ApplicationController
  def index
    @recipes = Recipe.all
  end

  def show
    @recipes = Recipe.all
    @recipe = Recipe.find_by(id: params[:id]) or redirect_to recipes_url
  end

  def cook
    @recipe = Recipe.find_by(id: params[:id]) or redirect_to recipes_url
    @url_back = recipe_url(@recipe)
    @url_forward = recipe_step_url(@recipe, 1)
  end
end
