require "application_system_test_case"

class RecipesTest < ApplicationSystemTestCase
  test "displaying all recipes" do
    visit recipes_url
    assert_selector 'li', count: Recipe.all.count
    assert_selector 'li', text: Recipe.first.title
  end
end
