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

  def test_new_statewide_test
    @str.new_statewide_test("TEST", 2999, "math", 9.999)
    require "pry"; binding.pry
    assert_equal ({2999=>{:math=>9.999}}), @str.find_by_name("TEST").third_grade
  end

  def test_create_statewide_test
    statewide_test = @str.create_statewide_test("TEST", 2999, "math", 9.999)
    require "pry"; binding.pry
    assert_equal ({2999=>{:math=>9.999}}), statewide_test.third_grade
  end

  def test_third_grade_load
    data = {2008=>{:math=>0.697, :reading=>0.703, :writing=>0.501},
       2009=>{:math=>0.691, :reading=>0.726, :writing=>0.536},
       2010=>{:math=>0.706, :reading=>0.698, :writing=>0.504},
       2011=>{:math=>0.696, :reading=>0.728, :writing=>0.513},
       2012=>{:reading=>0.739, :math=>0.71, :writing=>0.525},
       2013=>{:math=>0.72295, :reading=>0.73256, :writing=>0.50947},
       2014=>{:math=>0.71589, :reading=>0.71581, :writing=>0.51072}}
    assert_equal data, @str.statewide_tests["COLORADO"].third_grade
  end

  def test_eighth_grade_load
    data = {2008=>{:math=>0.469, :reading=>0.703, :writing=>0.529},
            2009=>{:math=>0.499, :reading=>0.726, :writing=>0.528},
            2010=>{:math=>0.51, :reading=>0.679, :writing=>0.549},
            2011=>{:reading=>0.67, :math=>0.513, :writing=>0.543},
            2012=>{:math=>0.515, :writing=>0.548, :reading=>0.671}, 2013=>{:math=>0.51482, :reading=>0.66888, :writing=>0.55788}, 2014=>{:math=>0.52385, :reading=>0.66351, :writing=>0.56183}}
    assert_equal data, @str.statewide_tests["COLORADO"].eighth_grade
  end

  def test_race_load
    data = {2011=>{:math=>0.5681, :reading=>0.7486, :writing=>0.6068},
            2012=>{:math=>0.5722, :reading=>0.77167, :writing=>0.5978},
            2013=>{:math=>0.5883, :reading=>0.77278, :writing=>0.623},
            2014=>{:math=>0.6048, :reading=>0.00778, :writing=>0.6244}}
    assert_equal data, @str.statewide_tests["ACADEMY 20"].race_ethnicity_data[:hispanic]
  end
end
