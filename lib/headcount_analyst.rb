require  'pry'

class HeadcountAnalyst
  attr_reader :district_repository, :calculate
  def initialize(dr)
    @district_repository = dr
  end

  def kindergarten_participation_rate_variation(name, against)
    numerator = calculate(name)
    denominator = calculate(against[:against])
    variation = (numerator / denominator).round(3)
    binding.pry
  end

  def kindergarten_participation_rate_variation_trend(name, against)
    a = @district_repository.districts[name].enrollment
    name_comparison = against[:against]
    a.kindergarten_participation_in_year(name_comparison)
    Clean.three_truncate(average)
    numerator =
    denominator =
    trend_variation = (numerator / denominator).round(3)
  end
  def calculate(name)
    years = @district_repository.find_by_name(name).enrollment.kindergarten_participation
    sum = years.reduce(0) do |sum, (key,value)|
      sum + years[key]
    end
    average = Clean.three_truncate(sum / years.count)
  end


  # def clean(percentage)
  #   percentage.to_s[0..4].to_f
  # end

end
