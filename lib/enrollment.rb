class Enrollment
  attr_reader :name, :kindergarten_participation_by_year
  def initialize(hash)
    @name = hash[:name].upcase
    @kindergarten_participation_by_year = hash[:kindergarten_participation]
  end

  def kindergarten_participation_in_year(year)
    percentage = clean(kindergarten_participation_by_year[year])
  end

  def kindergarten_participation_by_year
    kinder = @kindergarten_participation_by_year
    kinder.each do |key, value|
      kinder[key] = clean(kinder[key])
    end
    kinder
  end

  def clean(percentage)
    percentage.to_s[0..4].to_f
  end
end
