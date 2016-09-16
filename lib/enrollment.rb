require_relative 'clean'

class Enrollment
  include Clean
  attr_reader :name, :kindergarten_participation_by_year, :kindergarten_participation

  def initialize(hash)
    @name = hash[:name].upcase
    @kindergarten_participation = hash[:kindergarten_participation]
  end

  def kindergarten_participation_in_year(year)
    percentage = Clean.three_truncate(kindergarten_participation_by_year[year])
  end

  def kindergarten_participation_by_year
    kinder = @kindergarten_participation
    kinder.each do |key, value|
      kinder[key] = Clean.three_truncate(kinder[key])
    end
    kinder
  end
end
