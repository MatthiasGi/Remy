require 'test_helper'

class Admin::RecipesControllerTest < ActionDispatch::IntegrationTest
  test "index displays all available recipes" do
    get admin_recipes_url
    assert_response :success
    assert_equal Recipe.all, assigns(:recipes)
    assert_template :index
  end

  test "Edit invalid recipe" do
    get edit_admin_recipe_url(Recipe.last.id + 1)
    assert_redirected_to admin_recipes_url
  end

  test "Edit valid recipe" do
    get edit_admin_recipe_url(recipes(:default))
    assert_response :success
    assert_template :edit
    assert_equal recipes(:default), assigns(:recipe)

    get edit_admin_recipe_url(recipes(:full))
    assert_response :success
    assert_equal recipes(:full), assigns(:recipe)
    assert_not_equal recipes(:default), assigns(:recipe)
    assert_template :edit
  end

  test "update with wrong id" do
    patch admin_recipe_url(Recipe.last.id + 1)
    assert_redirected_to admin_recipes_url
  end

  test "update with wrong parameters" do
    recipe = recipes(:full)
    patch admin_recipe_url(recipe, params: { recipe: { title: '', duration: -5 }})
    assert_response :success
    assert_template :edit
    assert_equal recipe, assigns(:recipe)
    assert_select '.recipe_title.has-error .help-block'
    assert_select '.recipe_duration.has-error .help-block'
  end

  test "update valid parameters" do
    old = recipes(:full)
    patch admin_recipe_url(old, params: { recipe: { title: 'Testtext', description: 'Lorem ipsum dolor sit amet, längerer Testtext.', duration: 5000 }})
    assert_redirected_to admin_recipes_path
    new = Recipe.find(old.id)
    assert_not_equal old.title, new.title
    assert_equal 'Testtext', new.title
    assert_not_equal old.description, new.description
    assert_equal 'Lorem ipsum dolor sit amet, längerer Testtext.', new.description
    assert_not_equal old.duration, new.duration
    assert_equal 5000, new.duration
  end

  # TODO: Foto-Update (Löschen, kein Update, neues Foto)

  test "deleting recipe" do
    recipe = recipes(:full)
    delete admin_recipe_url(recipe)
    assert_redirected_to admin_recipes_url
    assert_not Recipe.find_by(id: recipe.id)
  end

  # TODO: Update (valid / invalid parameters)

  test "Page for new recipe is available" do
    get new_admin_recipe_url
    assert_response :success
    assert_template :new
    # assert assigns(:recipe)
  end

  # TODO: Create

  # TODO: Edit of steps

end
