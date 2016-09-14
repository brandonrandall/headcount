class Enrollment
  attr_reader :name, :kindergarten_participation_by_year
  def initialize(hash)
    @name = hash[:name]
    @kindergarten_participation_by_year= hash[:kindergarten_participation]
  end

  def kindergarten_participation_in_year(year)
    percentage = kindergarten_participation_by_year[year]
    # percentage.round(3)
  end
end
