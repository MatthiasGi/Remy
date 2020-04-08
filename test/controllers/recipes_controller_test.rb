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
end
