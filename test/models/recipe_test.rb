require 'test_helper'

class RecipeTest < ActiveSupport::TestCase
  setup do
    @image = Rails.root.join('test', 'fixtures', 'files', 'ratatouille.jpg')
    recipes(:full).image.attach(io: File.open(@image),
                                filename: 'ratatouille.jpg')
  end

  teardown do
    FileUtils.rm_rf("#{Rails.root}/tmp/storage")
  end

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

  test "image is accessible" do
    assert_not recipes(:default).image.attached?
    assert recipes(:full).image.attached?
    act = ActiveStorage::Blob.service.send(:path_for, recipes(:full).image.key)
    assert FileUtils.identical?(@image, act)
  end

  test "ingridients are linked and get deleted together" do
    recipe = recipes(:default)
    ingridients = []
    3.times do |i|
      ingridient = Ingridient.new(label: "Ingridient %d" % i, recipe: recipe)
      ingridient.save
      ingridients << ingridient
    end
    assert_equal ingridients, recipe.ingridients.to_a

    recipe.destroy
    assert_not Recipe.find_by(id: recipe.id)
    ingridients.each do |ingridient|
      assert_not Ingridient.find_by(id: ingridient.id)
    end
  end
end
