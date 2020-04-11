require 'test_helper'

class RecipesControllerTest < ActionDispatch::IntegrationTest
  test "index should yield all recipes" do
    get recipes_url
    assert_response :success
    assert_equal Recipe.all, assigns(:recipes)
    assert_template :index
  end

  test "show should yield all recipes and selected recipe" do
    get recipe_url(recipes(:default))
    assert_response :success
    assert_equal Recipe.all, assigns(:recipes)
    assert_equal recipes(:default), assigns(:recipe)
    assert_template :show
  end

  test "accessing invalid recipe redirects to index" do
    get recipe_url(Recipe.last.id + 1)
    assert_redirected_to recipes_url
  end

  test "cook view should deliver correct recipe" do
    recipe = recipes(:default)
    get recipe_cook_url(recipe)
    assert_equal recipe, assigns(:recipe)
  end

  test "cook view for invalid recipe redirects to index" do
    get recipe_cook_url(Recipe.last.id + 1)
    assert_redirected_to recipes_url
  end

  test "cook view should assign back and forward urls" do
    recipe = recipes(:full)
    get recipe_cook_url(recipe)
    assert_equal recipe_url(recipe), assigns(:url_back)
    assert_equal recipe_step_url(recipe, 1), assigns(:url_forward)
  end
end
