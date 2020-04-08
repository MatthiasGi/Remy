require 'test_helper'

class RecipeTest < ActiveSupport::TestCase
  test "needs title" do
    recipe = Recipe.new
    assert_not recipe.save
    recipe.title = "Testtitle"
    assert recipe.save
  end

  test "title shouldn't be blank" do
    recipe = Recipe.new(title: "")
    assert_not recipe.save
  end

  test "duration should be positive if given" do
    recipe = recipes(:default)
    recipe.duration = -5
    assert_not recipe.save
    recipe.duration = 0
    assert recipe.save
    recipe.duration = 2
    assert recipe.save
  end
end
