require_relative "data_extractor"

class StatewideTestRepository
  include DataExtractor

  def initialize
    @statewide_tests = {}
  end

  def load_data(file_data)
    contents = DataExtractor.extract(file_data, :statewide_testing)
    require "pry"; binding.pry
    contents.each do |key, value|
      contents_control(key, value)
    end
  end

  def contents_control(label, contents)
    require "pry"; binding.pry
    case label
    when :third_grade
      third_grade(contents)
    when :eighth_grade
      puts "eighth grade!"
    when :math
      puts "math!"
    when :reading
      puts "reading!"
    when :writing
      puts "writing!"
    end
  end

  def third_grade(contents)
    #make it and load it
    contents.each do |row|
      require "pry"; binding.pry
      statewide_test_existence(row)
    end
  end

  def statewide_test_existence(row)
    require "pry"; binding.pry
    name, year, subject, percentage = row[:location], row[:timeframe], row[:score], row[:data]
    new_data(name, year, subject, percentage)           if find_by_name(name)
    new_statewide_test(name, year, subject, percentage) unless find_by_name(name)
  end

  def new_data(name, year, subject, percentage)
    @statewide_tests[name].third_grade[year] = {subject.downcae.to_sym => percentage}
  end

  def new_statewide_test(name, year, subject, percentage)
    @statewide_tests[name] = create_statewide_test(name, year, subject, percentage)
  end

  def create_statewide_test(name, year, subject, percentage)
    StatewideTest.new(name).third_grade[year] = {subject.downcase.to_sym => percentage}
  end

  def find_by_name(name)
    require "pry"; binding.pry
    @statewide_tests[name.upcase]
  end
end
str = StatewideTestRepository.new
str.load_data({
  :statewide_testing => {
    :third_grade => "./test/fixtures/3rd grade students scoring proficient or above on the CSAP_TCAP.csv",
    :eighth_grade => "./test/fixtures/8th grade students scoring proficient or above on the CSAP_TCAP.csv",
    :math => "./test/fixtures/Average proficiency on the CSAP_TCAP by race_ethnicity_ Math.csv",
    :reading => "./test/fixtures/Average proficiency on the CSAP_TCAP by race_ethnicity_ Reading.csv",
    :writing => "./test/fixtures/Average proficiency on the CSAP_TCAP by race_ethnicity_ Writing.csv"
  }
})
