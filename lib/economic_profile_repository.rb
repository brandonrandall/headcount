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
      median_income(contents)
    when :children_in_poverty
      puts "children_in_poverty!"
    when :free_or_reduced_price_lunch
      puts "free lunch!"
    when :title_i
      puts "title one!"
    end
  end

  def median_income(contents)
    require "pry"; binding.pry
    contents.each do |row|
      economic_profile_existence(row)
    end
  end

  def economic_profile_existence(row)
    #if the economic_profile doesn't exist, make it with the data
    #otherwise, add the data to it (using median income data)
  end


end
