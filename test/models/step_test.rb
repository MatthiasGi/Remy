require 'test_helper'

class StepTest < ActiveSupport::TestCase
  test "step has to have recipe and number" do
    s = Step.new(number: 4, description: "Test")
    assert_not s.save
    s = Step.new(recipe: recipes(:default), description: "Test")
    assert_not s.save
    s.number = 4
    assert s.save
  end

  test "description shouldn't be blank" do
    s = Step.new(recipe: recipes(:default), number: 4)
    assert_not s.save
    s.description = ""
    assert_not s.save
    s.description = "Test"
    assert s.save
  end
end
