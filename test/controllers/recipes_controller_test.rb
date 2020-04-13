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

  test "step view should display correct step in order of number" do
    recipe = recipes(:full)

    get recipe_step_url(recipe, 1)
    assert_equal recipe, assigns(:recipe)
    assert_equal steps(:full_s1), assigns(:step)
    assert_equal recipe_cook_url(recipe), assigns(:url_back)
    assert_equal recipe_step_url(recipe, 2), assigns(:url_forward)
    assert_equal 1, assigns(:step_number)

    get recipe_step_url(recipe, 2)
    assert_equal recipe, assigns(:recipe)
    assert_equal steps(:full_s2), assigns(:step)
    assert_equal recipe_step_url(recipe, 1), assigns(:url_back)
    assert_equal recipe_step_url(recipe, 3), assigns(:url_forward)
    assert_equal 2, assigns(:step_number)

    get recipe_step_url(recipe, 3)
    assert_equal recipe, assigns(:recipe)
    assert_equal steps(:full_s3), assigns(:step)
    assert_equal recipe_step_url(recipe, 2), assigns(:url_back)
    assert_equal recipes_url, assigns(:url_forward)
    assert_equal 3, assigns(:step_number)
  end

  test "step view should redirect to index on wrong recipe number" do
    get recipe_step_url(Recipe.last.id + 1, 1)
    assert_redirected_to recipes_url
  end

  test "step view should redirect to recipe-view on invalid step" do
    recipe = recipes(:full)
    get recipe_step_url(recipe, 0)
    assert_redirected_to recipe_url(recipe)
    get recipe_step_url(recipe, 4)
    assert_redirected_to recipe_url(recipe)
  end
end
