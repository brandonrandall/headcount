require_relative '../lib/enrollment'
require 'csv'
require_relative '../lib/district_repository'
require_relative 'test_helper'
require_relative '../lib/headcount_analyst'

class HeadcountAnalystTest < Minitest::Test
  def setup
    dr = DistrictRepository.new
    dr.load_data({
      :enrollment => {
        :kindergarten => "./data/Kindergartners in full-day program.csv",
        :high_school_graduation => "./data/High school graduation rates.csv"
        }
      })
    @ha = HeadcountAnalyst.new(dr)
  end

  def test_it_holds_a_dr
    assert_equal DistrictRepository, @ha.district_repository.class
  end

  def test_it_can_access_enrollment_data
    district = @ha.district_repository.find_by_name("ACADEMY 20")
    assert_equal 0.436, district.enrollment.kindergarten_participation_in_year(2010)
  end

  def test_kindergarten_participation_rate_variation
    assert_equal 0.766, @ha.kindergarten_participation_rate_variation('ACADEMY 20', :against => 'COLORADO')
  end

  def test_kindergarten_participation_rate_variation_other_district
    assert_equal 0.447, @ha.kindergarten_participation_rate_variation('ACADEMY 20', :against => 'YUMA SCHOOL DISTRICT 1')
  end

  def test_calculate
    assert_equal 0.406, @ha.calculate("ACADEMY 20", "kindergarten_participation")
    assert_equal 0.898, @ha.calculate("ACADEMY 20", "high_school_graduation")
    assert_equal 0.751, @ha.calculate("COLORADO", "high_school_graduation")
  end

  def test_kindergarten_participation_rate_variation_trend
    result = {2004 => 1.257, 2005 => 0.96, 2006 => 1.05, 2007 => 0.992, 2008 => 0.717, 2009 => 0.652, 2010 => 0.681, 2011 => 0.727, 2012 => 0.688, 2013 => 0.694, 2014 => 0.661}
    assert_equal result, @ha.kindergarten_participation_rate_variation_trend('ACADEMY 20', :against => 'COLORADO')
  end

  def test_variation_trend_calculator
    numerator = {2007=>0.39159, 2006=>0.35364, 2005=>0.26709, 2004=>0.30201, 2008=>0.38456, 2009=>0.39, 2010=>0.43628, 2011=>0.489, 2012=>0.47883, 2013=>0.48774, 2014=>0.49022}
    denominator = {2007=>0.39465, 2006=>0.33677, 2005=>0.27807, 2004=>0.24014, 2008=>0.5357, 2009=>0.598, 2010=>0.64019, 2011=>0.672, 2012=>0.695, 2013=>0.70263, 2014=>0.74118}
    result = {2004 => 1.257, 2005 => 0.96, 2006 => 1.05, 2007 => 0.992, 2008 => 0.717, 2009 => 0.652, 2010 => 0.681, 2011 => 0.727, 2012 => 0.688, 2013 => 0.694, 2014 => 0.661}
    assert_equal result, @ha.variation_trend_calculator(numerator, denominator)
  end

  def test_kindergarten_participation_against_high_school_graduation
    assert_equal 0.641, @ha.kindergarten_participation_against_high_school_graduation("ACADEMY 20")
    assert_equal 0.548, @ha.kindergarten_participation_against_high_school_graduation('MONTROSE COUNTY RE-1J')
    assert_equal 0.801, @ha.kindergarten_participation_against_high_school_graduation('STEAMBOAT SPRINGS RE-2')
  end

  def test_districts_correlation
    assert_equal true, @ha.districts_correlation(for: "ACADEMY 20")
  end

  def test_variation_validator
    assert @ha.variation_validator(0.6)
    assert @ha.variation_validator(1.5)
    assert @ha.variation_validator(1.0)
    refute @ha.variation_validator(0.5)
    refute @ha.variation_validator(1.6)
  end

  def test_statewide_validator
    assert @ha.statewide_validator(0.71)
    refute @ha.statewide_validator(0.22)
  end

  def test_kindergarten_participation_correlates_with_high_school_graduation
    assert_equal true, @ha.kindergarten_participation_correlates_with_high_school_graduation(for: 'ACADEMY 20')
  end

  def test_correlation_statewide
    refute @ha.kindergarten_participation_correlates_with_high_school_graduation(:for => 'STATEWIDE')
  end
end
