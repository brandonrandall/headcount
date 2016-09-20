require_relative 'test_helper'
require_relative '../lib/economic_profile'

class EconomicProfileTest < MiniTest::Test
  def test_it_exists
    ep = EconomicProfile.new({name: "frank"})
    assert_instance_of EconomicProfile, ep
  end
end
