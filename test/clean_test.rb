require 'minitest/autorun'
require_relative 'test_helper'
require 'pry'
require 'minitest/pride'
require_relative '../lib/clean'

class CleanerTest < Minitest::Test
  include Clean

  def test_three_truncate
    assert_equal 0.987, Clean.three_truncate(0.98735353)
    assert_equal 0.987, Clean.three_truncate(0.987654)
  end

  def test_three_round
    assert_equal 0.988, Clean.three_round(0.987654)
    refute_equal 0.987, Clean.three_round(0.9877442)
  end


end
