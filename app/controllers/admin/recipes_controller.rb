class Admin::RecipesController < ApplicationController

  before_action :get_recipe, only: [:edit, :update, :destroy]

  def index
    @recipes = Recipe.all
  end

  def edit; end

  def update
    @recipe.update(recipe_params) or return render :edit
    redirect_to admin_recipes_url
  end

  def new; end

  def destroy
    @recipe.destroy
    redirect_to admin_recipes_url
  end

  private

  def get_recipe
    @recipe = Recipe.find_by(id: params[:id]) or redirect_to admin_recipes_url
  end

  def recipe_params
    params.require(:recipe).permit(:title, :description, :duration)
  end

end
