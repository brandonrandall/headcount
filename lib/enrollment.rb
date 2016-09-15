class Enrollment
  attr_reader :name, :kindergarten_participation_by_year
  def initialize(hash)
    @name = hash[:name].upcase
    @kindergarten_participation_by_year = hash[:kindergarten_participation]
  end

  def kindergarten_participation_in_year(year)
    percentage = kindergarten_participation_by_year[year]
  end
end
