require 'test_helper'

class IngridientTest < ActiveSupport::TestCase
  test "ingridient has to have recipe" do
    i = Ingridient.new(label: "Zitronensaft")
    assert_not i.save
    i.recipe = recipes(:default)
    assert i.save
  end

  test "Ingridient has to have label" do
    i = Ingridient.new(recipe: recipes(:default))
    assert_not i.save
    i.label = ""
    assert_not i.save
    i.label = "Salz"
    assert i.save
  end
end
