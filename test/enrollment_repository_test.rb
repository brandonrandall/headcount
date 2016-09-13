require_relative 'test_helper'
require_relative '../lib/enrollment_repository'

class EnrollmentRepositoryTest < Minitest::Test
  def test_something
    er = EnrollmentRepository.new
    er.load_data({
      :enrollment => {
        :kindergarten => "./data/Kindergartners in full-day program.csv"
      }
    })
    enrollment = er.find_by_name("ACADEMY 20")

    assert_equal "ACADEMY 20", enrollment.name
  end

  def test_puts_multiple_years_in_kindergarten_participation_hash
    er = EnrollmentRepository.new
    er.load_data({
      :enrollment => {
        :kindergarten => "./test/fixtures/Kindergartners in full-day program.csv"
      }
    })
    enrollment = er.find_by_name("academy 20")
    years = ({"2007"=>"0.39159", "2006"=>"0.35364",
              "2005"=>"0.26709", "2004"=>"0.30201",
              "2008"=>"0.38456", "2009"=>"0.39",
              "2010"=>"0.43628", "2011"=>"0.489",
              "2012"=>"0.47883", "2013"=>"0.48774",
              "2014"=>"0.49022"})

    assert_equal years, enrollment.kindergarten_participation_by_year
  end
end
