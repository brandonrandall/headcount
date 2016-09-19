require_relative 'test_helper'
require_relative '../lib/economic_profile_repository'

class EconomicProfileRepositoryTest < MiniTest::Test
  def test_it_exists
    epr = EconomicProfileRepository.new
    assert_instance_of EconomicProfileRepository, epr 
  end
end
