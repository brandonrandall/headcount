class Enrollment
  attr_reader :name, :kindergarten_participation_by_year
  def initialize(hash)
    @name = hash[:name]
    @kindergarten_participation_by_year = hash[:kindergarten_participation]
  end

  def kindergarten_participation_in_year(year)
    # given year, lookup percentage for that year
    # return percentage, formatted appropriately
  end
end
