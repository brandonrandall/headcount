require_relative 'test_helper'
require_relative '../lib/economic_profile_repository'

class EconomicProfileRepositoryTest < MiniTest::Test
  def setup
    @epr = EconomicProfileRepository.new
    @epr.load_data({
        :economic_profile => {
          :median_household_income => "./test/fixtures/Median household income.csv",
          :children_in_poverty => "./test/fixtures/School-aged children in poverty.csv",
          :free_or_reduced_price_lunch => "./test/fixtures/Students qualifying for free or reduced price lunch.csv",
          :title_i => "./test/fixtures/Title I students.csv"
          }})
  end

  def test_it_exists
    assert_instance_of EconomicProfileRepository, @epr
  end
end
