require 'test_helper'

class RecipesControllerTest < ActionDispatch::IntegrationTest
  test "index should display all recipes" do
    get recipes_url
    assert_response :success
  end
end
