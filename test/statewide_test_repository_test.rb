require_relative "test_helper"
require_relative "../lib/statewide_test_repository"

class StatewideTestRepositoryTest < Minitest::Test
  def setup
    @str = StatewideTestRepository.new
    @str.load_data({
      :statewide_testing => {
        :third_grade => "./test/fixtures/3rd grade students scoring proficient or above on the CSAP_TCAP.csv",
        :eighth_grade => "./test/fixtures/8th grade students scoring proficient or above on the CSAP_TCAP.csv",
        :math => "./test/fixtures/Average proficiency on the CSAP_TCAP by race_ethnicity_ Math.csv",
        :reading => "./test/fixtures/Average proficiency on the CSAP_TCAP by race_ethnicity_ Reading.csv",
        :writing => "./test/fixtures/Average proficiency on the CSAP_TCAP by race_ethnicity_ Writing.csv"
      }
    })
    require "pry"; binding.pry
  end

  def test_new_statewide_test
    @str.new_statewide_test("Colorado", "2008", "Math", "0.697")
    assert_equal ({"2008"=>{:math=>"0.697"}}), @str.statewide_tests["Colorado"].third_grade
  end

  def test_create_statewide_test
    @str.create_statewide_test("Colorado", "2008", "Math", "0.697")
    statewide_test = "#<StatewideTest:0x007f96b0cc8758 @eighth_grade={}, @math={}, @name='COLORADO', @reading={}, @third_grade={'2008'=>{:math=>'0.697'}}, @writing={}>"
    # require "pry"; binding.pry
    assert_equal statewide_test, @str.statewide_tests["Colorado"].to_s
  end
end
