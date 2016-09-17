require  'pry'

class HeadcountAnalyst
  attr_reader :district_repository, :calculate, :kindergarten_participation_against_high_school_graduation
  def initialize(dr)
    @district_repository = dr
  end

  def kindergarten_participation_rate_variation(name, against)
    numerator = calculate_kinder(name)
    denominator = calculate_kinder(against[:against])
    variation = (numerator / denominator).round(3)
  end

  def kindergarten_participation_against_high_school_graduation(name)
    numerator = kindergarten_participation_rate_variation(name, :against => "COLORADO")
    denominator = calculate_high(name) / calculate_high("COLORADO")
    variation = (numerator / denominator).round(3)
  end

  def calculate_kinder(name)
    years = @district_repository.find_by_name(name).enrollment.kindergarten_participation
    sum = years.reduce(0) do |sum, (key,value)|
      sum + years[key]
    end
    average = Clean.three_truncate(sum / years.count)
  end

  def calculate_high(name)
    years = @district_repository.find_by_name(name).enrollment.high_school_graduation
    sum = years.reduce(0) do |sum, (key,value)|
      sum + years[key]
    end
    average = Clean.three_truncate(sum / years.count)
  end

  def kindergarten_participation_rate_variation_trend(name, against)
    numerator = @district_repository.find_by_name(name).enrollment.kindergarten_participation
    denominator = @district_repository.find_by_name(against[:against]).enrollment.kindergarten_participation
    variation_trend_calculator(numerator, denominator)
  end

  def variation_trend_calculator(numerator, denominator)
    result = {}
    numerator.each do |key,value|
      result[key] = Clean.three_truncate(numerator[key]/denominator[key])
    end
    result
  end

  def kindergarten_participation_correlates_with_high_school_graduation(name)
    name[:for] == "STATEWIDE" ? statewide_correlation : districts_correlation(name)
  end

  def districts_correlation(name)
    variation = kindergarten_participation_against_high_school_graduation(name[:for])
    variation_validator(variation)
  end

  def statewide_correlation
    require "pry"; binding.pry
    sum = 0
    @district_repository.districts.each do |key, value|
      sum += 1 if variation_validator(kindergarten_participation_against_high_school_graduation(key))
    end
    variation = sum / @district_repository.districts.count
    variation_validator(variation)
  end

  def variation_validator(variation)
    if variation >= 0.6 && variation <= 1.5
      return true
    else
      return false
    end
  end

end
