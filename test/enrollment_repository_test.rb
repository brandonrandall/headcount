require_relative 'test_helper'
require_relative '../lib/enrollment_repository'

class EnrollmentRepositoryTest < Minitest::Test

  def test_find_by_name
    er = EnrollmentRepository.new
    er.load_data({
      :enrollment => {
        :kindergarten => "./data/Kindergartners in full-day program.csv"
      }
      })
    enrollment = er.find_by_name("ACADEMY 20")
    assert_equal "ACADEMY 20", enrollment.name
  end

  def test_inappropriate_search_returns_nil
    er = EnrollmentRepository.new
    er.load_data({
      :enrollment => {
        :kindergarten => "./test/fixtures/Kindergartners in full-day program.csv"
      }
    })
    enrollment = er.find_by_name("I am not a value in the dataset")
    assert_equal nil, enrollment
  end

  def test_multiple_years_data_in_kindergarten_participation_hash

    er = EnrollmentRepository.new
    er.load_data({
      :enrollment => {
        :kindergarten => "./test/fixtures/Kindergartners in full-day program.csv"
      }
    })
    enrollment = er.find_by_name("academy 20")
    years =   {2007=>0.391, 2006=>0.353,
              2005=>0.267, 2004=>0.302,
              2008=>0.384, 2009=>0.39,
              2010=>0.436, 2011=>0.489,
              2012=>0.478, 2013=>0.487,
              2014=>0.490}
    assert_equal years, enrollment.kindergarten_participation_by_year
  end

end
