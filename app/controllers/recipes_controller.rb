class RecipesController < ApplicationController
  def index
    @recipes = Recipe.all
  end

  def show
    @recipes = Recipe.all
    @recipe = Recipe.find_by(id: params[:id]) or redirect_to recipes_url
  end

  def cook
  end
end
