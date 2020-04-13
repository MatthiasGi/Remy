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

  test "clicking on cook-button opens cook-interface with ingridients" do
    recipe = recipes(:full)
    visit recipe_url(recipe)
    click_on I18n.t('recipes.list.cook')
    assert_equal recipe_cook_path(recipe), current_path

    recipe.ingridients.each do |ingridient|
      ingridient.quantity.nil? or assert_text ingridient.quantity
      assert_text ingridient.label
    end

    # Back and forward buttons
    assert_selector :xpath, '//a[contains(@href, "%s")]' % recipe_path(recipe)
    assert_selector :xpath, '//a[contains(@href, "%s")]' % recipe_step_path(recipe, 1)
  end

  test "clicking through step_view" do
    recipe = recipes(:full)
    visit recipe_cook_url(recipe)
    click_on I18n.t('recipes.steps.forward')

    assert_equal recipe_step_path(recipe, 1), current_path
    assert_text steps(:full_s1).description
    assert_text '1/3'
    click_on I18n.t('recipes.steps.forward')

    assert_equal recipe_step_path(recipe, 2), current_path
    assert_text steps(:full_s2).description
    assert_text '2/3'
    click_on I18n.t('recipes.steps.forward')

    assert_equal recipe_step_path(recipe, 3), current_path
    assert_text steps(:full_s3).description
    assert_text '3/3'
    click_on I18n.t('recipes.steps.forward')

    assert_equal recipes_path, current_path
  end
end
