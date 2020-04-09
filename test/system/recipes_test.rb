require "application_system_test_case"

class RecipesTest < ApplicationSystemTestCase
  driven_by :selenium, using: :headless_chrome

  setup do
    @image = Rails.root.join('test', 'fixtures', 'files', 'ratatouille.jpg')
    recipes(:full).image.attach(io: File.open(@image),
                                filename: 'ratatouille.jpg')
  end

  teardown do
    FileUtils.rm_rf("#{Rails.root}/tmp/storage")
  end

  test "displaying message when no recipes available" do
    Recipe.delete_all
    visit recipes_url
    assert_selector '.alert', text: I18n.t('recipes.list.no_recipes')
  end

  test "displaying all recipes" do
    visit recipes_url
    Recipe.all.each do |recipe|
      assert_selector 'a.nav-item', text: recipe.title
    end
  end

  test "displaying all recipes and recipe details when selecting a recipe" do
    recipe = recipes(:full)
    visit recipe_url(recipe)
    Recipe.all.each do |recipe|
      assert_selector 'a.nav-item', text: recipe.title
    end

    assert_selector 'h1', text: recipe.title
    assert_selector 'p', text: recipe.description
    assert_selector 'p', text: "1:05:30"
    src = Rails.application.routes.url_helpers.rails_blob_path(recipe.image, only_path: true)
    assert_selector :xpath, '//img[contains(@src, ratatouille.jpg)]'
  end

  test "no image shown if recipe has no image" do
    visit recipe_url(recipes(:default))
    assert_no_selector 'img'
  end

  test "selecting recipe makes corresponding element active" do
    visit recipes_url
    title = recipes(:default).title
    click_on title
    assert_selector 'a.nav-item.active', text: title
  end

  test "clicking on cook-button opens cook-interface" do
    visit recipe_url(recipes(:full))
    click_on I18n.t('recipes.list.cook')
    assert_equal recipecook_path(recipes(:full)), current_path
  end
end
