require_relative '../lib/enrollment'
require 'csv'
require_relative '../lib/district_repository'
require_relative 'test_helper'
require_relative '../lib/headcount_analyst'

class HeadcountAnalystTest < Minitest::Test
  def test_it_holds_a_dr
    dr = DistrictRepository.new
    dr.load_data({
      :enrollment => {
        :kindergarten => "./test/fixtures/Kindergartners in full-day program.csv"
      }
    })
    ha = HeadcountAnalyst.new(dr)
    assert_equal DistrictRepository, ha.district_repository.class
  end

  def test_it_can_access_enrollment_data
    dr = DistrictRepository.new
    dr.load_data({
      :enrollment => {
        :kindergarten => "./test/fixtures/Kindergartners in full-day program.csv"
      }
    })
    ha = HeadcountAnalyst.new(dr)
    district = ha.district_repository.find_by_name("ACADEMY 20")
    assert_equal 0.436, district.enrollment.kindergarten_participation_in_year(2010)
  end

  def test_calculate
    dr = DistrictRepository.new
    dr.load_data({
      :enrollment => {
        :kindergarten => "./test/fixtures/Kindergartners in full-day program.csv"
      }
    })
    ha = HeadcountAnalyst.new(dr)
    assert_equal 0.406, ha.calculate("ACADEMY 20")
  end

  def test_kindergarten_participation_rate_variation
    dr = DistrictRepository.new
    dr.load_data({
      :enrollment => {
        :kindergarten => "./test/fixtures/Kindergartners in full-day program.csv"
      }
    })
    ha = HeadcountAnalyst.new(dr)
    assert_equal 0.766, ha.kindergarten_participation_rate_variation('ACADEMY 20', :against => 'COLORADO')
  end

  def test_kindergarten_participation_rate_variation_other_district
    dr = DistrictRepository.new
    dr.load_data({
      :enrollment => {
        :kindergarten => "./test/fixtures/Kindergartners in full-day program.csv"
      }
    })
    ha = HeadcountAnalyst.new(dr)
    assert_equal 0.447, ha.kindergarten_participation_rate_variation('ACADEMY 20', :against => 'YUMA SCHOOL DISTRICT 1')
  end

  def test_calculate
    dr = DistrictRepository.new
    dr.load_data({
      :enrollment => {
        :kindergarten => "./test/fixtures/Kindergartners in full-day program.csv"
      }
    })
    ha = HeadcountAnalyst.new(dr)
    assert_equal 0.406, ha.calculate("ACADEMY 20")
  end

  def test_kindergarten_participation_rate_variation_trend
    dr = DistrictRepository.new
    dr.load_data({
      :enrollment => {
        :kindergarten => "./test/fixtures/Kindergartners in full-day program.csv"
      }
    })
    ha = HeadcountAnalyst.new(dr)
    result = {2004 => 1.257, 2005 => 0.96, 2006 => 1.05, 2007 => 0.992, 2008 => 0.717, 2009 => 0.652, 2010 => 0.681, 2011 => 0.727, 2012 => 0.688, 2013 => 0.694, 2014 => 0.661}
    assert_equal result, ha.kindergarten_participation_rate_variation_trend('ACADEMY 20', :against => 'COLORADO')
  end
  def test_variation_trend_calculator
    dr = DistrictRepository.new
    dr.load_data({
      :enrollment => {
        :kindergarten => "./test/fixtures/Kindergartners in full-day program.csv"
      }
    })
    ha = HeadcountAnalyst.new(dr)
    numerator = {2007=>0.39159, 2006=>0.35364, 2005=>0.26709, 2004=>0.30201, 2008=>0.38456, 2009=>0.39, 2010=>0.43628, 2011=>0.489, 2012=>0.47883, 2013=>0.48774, 2014=>0.49022}
    denominator = {2007=>0.39465, 2006=>0.33677, 2005=>0.27807, 2004=>0.24014, 2008=>0.5357, 2009=>0.598, 2010=>0.64019, 2011=>0.672, 2012=>0.695, 2013=>0.70263, 2014=>0.74118}
    result = {2004 => 1.257, 2005 => 0.96, 2006 => 1.05, 2007 => 0.992, 2008 => 0.717, 2009 => 0.652, 2010 => 0.681, 2011 => 0.727, 2012 => 0.688, 2013 => 0.694, 2014 => 0.661}
    assert_equal result, ha.variation_trend_calculator(numerator, denominator)
  end
end
