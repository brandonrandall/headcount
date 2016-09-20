require_relative 'exceptions'
class EconomicProfile
  attr_reader :name, :median_household_income, :children_in_poverty,
              :free_or_reduced_price_lunch, :title_i

  def initialize(data)
    @name = data[:name]
    @median_household_income = data[:median_household_income] || {}
    @children_in_poverty = data[:children_in_poverty] || {}
    @free_or_reduced_price_lunch = data[:free_or_reduced_price_lunch] || {}
    @title_i = data[:title_i] || {}
  end

  def median_household_income_in_year(year)
    raise UnknownDataError,
      "Unknown year" unless (2005..2013).to_a.include?(year)
    counter = 0
    sum = 0
    result = @median_household_income.each do |years, income|
      if year.between? years.first, years.last
        sum += income
        counter +=1
      end
    end
    average = sum / counter
  end

  def median_household_income_average

  end

  # def children_in_poverty_in_year(year)
  # end
  #
  # def free_or_reduced_price_lunch_percentage_in_year(year)
  # end
  #
  # def free_or_reduced_price_lunch_number_in_year(year)
  # end
  #
  # def title_i_in_year(year)
  # end

end
