require_relative "test_helper"
require_relative "../lib/statewide_test"

class StatewideTestTest < Minitest::Test
  def test_it_exists
    statewide_test = StatewideTest.new("test")
    assert_equal StatewideTest, statewide_test.class
  end

  def test_it_can_hold_data
    statewide_test = StatewideTest.new("test")
    statewide_test.third_grade["something"] = "data"
    assert_equal ({"something" => "data"}), statewide_test.third_grade
  end

  def test_it_can_hold_third_grade
    statewide_test = StatewideTest.new("test")
    year, subject, percentage = "2008", "Math", "0.697"
    statewide_test.third_grade[year] = {subject.downcase.to_sym => percentage}
    assert_equal ({"2008"=>{:math=>"0.697"}}), statewide_test.third_grade
  end
end
