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
    # require "pry"; binding.pry
  end

  def test_create_statewide_test
    data = {2008=>{:math=>0.697, :reading=>0.703, :writing=>0.501},
       2009=>{:math=>0.691, :reading=>0.726, :writing=>0.536},
       2010=>{:math=>0.706, :reading=>0.698, :writing=>0.504},
       2011=>{:math=>0.696, :reading=>0.728, :writing=>0.513},
       2012=>{:reading=>0.739, :math=>0.71, :writing=>0.525},
       2013=>{:math=>0.72295, :reading=>0.73256, :writing=>0.50947},
       2014=>{:math=>0.71589, :reading=>0.71581, :writing=>0.51072}}
    # require "pry"; binding.pry
    assert_equal data, @str.statewide_tests["COLORADO"].third_grade
  end
end
