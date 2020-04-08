require 'test_helper'

class RecipesHelperTest < ActionView::TestCase
  include RecipesHelper

  test "output formatted duration" do
    act = duration(recipes(:full))
    assert_equal '1:05:30', act
  end

  test "output for not-existing duration blank" do
    assert_empty duration(recipes(:default))
  end

  test "output for only minutes" do
    act = duration(recipes(:minutes))
    assert_equal '2:03', act
  end

  test "output for only seconds" do
    act = duration(recipes(:seconds))
    assert_equal '0:05', act
  end
end
