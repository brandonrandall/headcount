class Enrollment
  attr_reader :name, :kindergarten_participation_by_year
  def initialize(hash)
    @name = hash[:name]
    @kindergarten_participation_by_year= hash[:kindergarten_participation]
    # @kindergarten_participation = hash[:kindergarten_participation]
  end

  def kindergarten_participation_by_year
    # @kindergarten_participation
    # # kindergarten_values = {}
    # # @kindergarten_participation.each do |key, value|
    # #   kindergarten_values[key.to_i] = value.to_s[0..4].to_f
    # end
    # kindergarten_values
  end

  def kindergarten_participation_in_year(year)
    percentage = kindergarten_participation_by_year[year]
    percentage.round(3)
  end
end
