require_relative "data_extractor"

class StatewideTestRepository
  include DataExtractor

  def initialize
    @statewide_tests = {}
  end

  def load_data(file_data)
    contents = DataExtractor.extract(file_data, :statewide_testing)
    # require "pry"; binding.pry
  end
end

str = StatewideTestRepository.new
str.load_data({
  :statewide_testing => {
    :third_grade => "./data/3rd grade students scoring proficient or above on the CSAP_TCAP.csv",
    :eighth_grade => "./data/8th grade students scoring proficient or above on the CSAP_TCAP.csv",
    :math => "./data/Average proficiency on the CSAP_TCAP by race_ethnicity_ Math.csv",
    :reading => "./data/Average proficiency on the CSAP_TCAP by race_ethnicity_ Reading.csv",
    :writing => "./data/Average proficiency on the CSAP_TCAP by race_ethnicity_ Writing.csv"
  }
})
