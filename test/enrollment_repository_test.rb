require_relative 'test_helper'
require_relative '../lib/enrollment_repository'

class EnrollmentRepositoryTest < Minitest::Test

  def test_connecting
    er = EnrollmentRepository.new
    er.load_data({
      :enrollment => {
        :kindergarten => "./data/Kindergartners in full-day program.csv"
      }
    })
    enrollment = er.find_by_name("ACADEMY 20")

    assert_equal "ACADEMY 20", enrollment.name
  end


end
