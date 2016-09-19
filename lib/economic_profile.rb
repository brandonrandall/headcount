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

  # def median_household_income_in_year(year)
  # end
  #
  # def median_household_income_average
  # end
  #
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
