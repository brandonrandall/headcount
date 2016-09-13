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

    require "pry"; binding.pry
    assert_equal "ACADEMY 20", enrollment.name
  end

  # test_it_can_handle_a_single_key_value_pair_in_the_hash
  #test_it_can_add_new_key_value_to_existing_participation_hash
end
