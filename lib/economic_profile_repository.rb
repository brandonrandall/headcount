require_relative 'clean'
require_relative 'data_extractor'
require_relative 'economic_profile'

class EconomicProfileRepository
  include Clean
  include DataExtractor

  attr_reader :economic_profiles

  def initialize
    @economic_profiles = {}
  end

  def load_data(file_data)
    contents = DataExtractor.extract(file_data, :economic_profile)
    contents.each do |label, contents|
      contents_control(label, contents)
    end
  end

  def contents_control(label, contents)
    case label
    when :median_household_income
      median_income(contents)
    when :children_in_poverty
      child_poverty(contents)
    when :free_or_reduced_price_lunch
      puts "free lunch!"
    when :title_i
      puts "title one!"
    end
  end

  def child_poverty(contents)
    contents.each do |row|
      add_poverty_data(row) if row[:dataformat] == "Percent"
    end
  end

  def add_poverty_data(row)
    name, year = row[:location].upcase, row[:timeframe].to_i
    percentage = row[:data].to_f
    # require "pry"; binding.pry
    find_by_name(name).children_in_poverty[year] = percentage
  end


  def median_income(contents)
    contents.each do |row|
      economic_profile_existence(row)
    end
  end

  def economic_profile_existence(row)
    name, years, median_income = row[:location].upcase, Clean.timeframe(row[:timeframe]), row[:data].to_i
    new_median_data(name, years, median_income)      if find_by_name(name)
    new_economic_profile(name, years, median_income) unless find_by_name(name)
  end

  def new_economic_profile(name, years, median_income)
    @economic_profiles[name] = EconomicProfile.new({name: name})
    @economic_profiles[name].median_household_income[years] = median_income
  end

  def new_median_data(name, years, median_income)
    @economic_profiles[name].median_household_income[years] = median_income
  end


  def find_by_name(name)
    @economic_profiles[name.upcase]
  end


end
