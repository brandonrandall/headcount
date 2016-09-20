require_relative 'test_helper'
require_relative '../lib/economic_profile'
require_relative '../lib/economic_profile_repository'

class EconomicProfileTest < MiniTest::Test
  def test_it_exists
    ep = EconomicProfile.new({name: "frank"})
    assert_instance_of EconomicProfile, ep
  end

  def setup
    @epr = EconomicProfileRepository.new
    @epr.load_data({
        :economic_profile => {
          :median_household_income => "./data/Median household income.csv",
          :children_in_poverty => "./data/School-aged children in poverty.csv",
          :free_or_reduced_price_lunch => "./data/Students qualifying for free or reduced price lunch.csv",
          :title_i => "./data/Title I students.csv"
          }})
  end

  def test_median_household_income_average
    academy = @epr.find_by_name("Academy 20")
    # require "pry"; binding.pry
    assert_equal 86203, academy.median_household_income_in_year(2007)
    assert_equal 89953, academy.median_household_income_in_year(2013)
    assert_raises(UnknownDataError) do
      academy.median_household_income_in_year(2033)
    end
  end
end
