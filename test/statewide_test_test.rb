require_relative "test_helper"
require_relative "../lib/statewide_test"

class StatewideTestTest < Minitest::Test
  def test_it_exists
    statewidetest = StatewideTest.new
    assert_equal StatewideTest, statewidetest.class
  end

  def test_it_can_hold_data
    statewidetest = StatewideTest.new
    statewidetest.third_grade["something"] = "data"
    assert_equal ({"something" => "data"}), statewidetest.third_grade
  end
end
