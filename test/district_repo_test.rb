require_relative 'test_helper'
require_relative '../lib/district_repository'
require 'csv'



class DistrictRepositoryTest < Minitest::Test

  def test_find_by_name
    dr = DistrictRepository.new
    dr.load_data({
      :enrollment => {
        :kindergarten => "./data/Kindergartners in full-day program.csv"
      }
    })
    district = dr.find_by_name("ACADEMY 20")
    assert_equal "ACADEMY 20", district.name
  end

  def test_district_existence
    dr = DistrictRepository.new
    dr.districts["denver"] = District.new({name: "denver"})
    dr.district_existence("denver")
    assert_equal 1, dr.districts.keys.length

    dr.district_existence("lakewood")
    assert_equal 2, dr.districts.keys.length
  end

  def test_find_all_matching
    dr = DistrictRepository.new
    dr.load_data({
      :enrollment => {
        :kindergarten => "./data/Kindergartners in full-day program.csv"
      }
    })
    districts = dr.find_all_matching("aG")
    
    assert_equal 4, districts.count
  end

  def test_find_all_matching_no_match
    dr = DistrictRepository.new
    dr.load_data({
      :enrollment => {
        :kindergarten => "./test/fixtures/Kindergartners in full-day program.csv"
      }
    })
    districts = dr.find_all_matching("aG")

    assert_equal [], districts
  end

end
