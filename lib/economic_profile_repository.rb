require_relative 'clean'
require_relative 'data_extractor'

class EconomicProfileRepository
  include Clean
  include DataExtractor

  def load_data(file_data)
    contents = DataExtractor.extract(file_data, :economic_profile)
    contents.each do |key, value|
      contents_control(key, value)
    end
  end

  def contents_control(label, contents)
    case label
    when :median_household_income
      require "pry"; binding.pry
      puts "median household income!"
    when :children_in_poverty
      puts "children_in_poverty!"
    when :free_or_reduced_price_lunch
      puts "free lunch!"
    when :title_i
      puts "title one!"
    end
  end


end
