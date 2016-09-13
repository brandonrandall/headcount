require_relative 'test_helper'
require_relative '../lib/enrollment'

class EnrollmentTest < Minitest::Test
  def test_enrollment_can_be_created
    e = Enrollment.new({:name => "ACADEMY 20", :kindergarten_participation => {2010 => 0.3915, 2011 => 0.35356, 2012 => 0.2677}})

    assert_equal Enrollment, e.class
  end

  def test_it_has_a_name
    e = Enrollment.new({:name => "ACADEMY 20", :kindergarten_participation => {2010 => 0.3915, 2011 => 0.35356, 2012 => 0.2677}})

    assert_equal "ACADEMY 20", e.name
  end

  def test_it_has_kindergarten_participation_by_year
    e = Enrollment.new({:name => "ACADEMY 20", :kindergarten_participation => {2010 => 0.3915, 2011 => 0.35356, 2012 => 0.2677}})
require "pry"; binding.pry
    assert_equal ({2010 => 0.3915, 2011 => 0.35356, 2012 => 0.2677}), e.kindergarten_participation_by_year
  end

  def test_it_returns_kindergarten_participation_in_a_given_year
    e = Enrollment.new({:name => "ACADEMY 20", :kindergarten_participation => {2010 => 0.3915, 2011 => 0.35356, 2012 => 0.2677}})
    assert_equal 0.392, e.kindergarten_participation_in_year(2010)
  end

  # test_it_can_handle_a_single_key_value_pair_in_the_hash
  #test_it_can_add_new_key_value_to_existing_participation_hash
end
