require_relative "data_extractor"
require_relative "clean"
require_relative "statewide_test"

class StatewideTestRepository
  include DataExtractor
  include Clean
  attr_reader :statewide_tests, :find_by_name
  def initialize
    @statewide_tests = {}
  end

  def load_data(file_data)
    contents = DataExtractor.extract(file_data, :statewide_testing)
    contents.each do |key, value|
      contents_control(key, value)
    end
  end

  def contents_control(label, contents)
    case label
    when :third_grade
      grade(contents, "third_grade")
    when :eighth_grade
      grade(contents, "eighth_grade")
    when :math
      math_race_data(contents)
    when :reading
      puts "reading!"
    when :writing
      puts "writing!"
    end
  end

  def math_race_data(contents)
    contents.each do |row|
      add_math_race_data(row)
    end
  end

  def add_math_race_data(row)
    name, race_ethnicity, year, subject, percentage = row[:location].upcase, Clean.race_ethnicity(row[:race_ethnicity]), row[:timeframe].to_i, :math, row[:data].to_f
    race_ethnicity_check(name, race_ethnicity, year, subject, percentage)
  end

  def race_ethnicity_check(name, race_ethnicity, year, subject, percentage)
    statewide_tests = @statewide_tests[name].race_ethnicity_data
    if statewide_tests.keys.include?(race_ethnicity)
      year_check(name, race_ethnicity, year, subject, percentage)
    else
      add_by_ethnicity(name, race_ethnicity, year, subject, percentage)
    end
  end

  def year_check(name, race_ethnicity, year, subject, percentage)
    statewide_tests = @statewide_tests[name].race_ethnicity_data
    if statewide_tests[race_ethnicity].keys.include?(year)
      add_by_subject(name, race_ethnicity, year, subject, percentage)
    else
      add_by_year(name, race_ethnicity, year, subject, percentage)
    end
  end

  def add_by_ethnicity(name, race_ethnicity, year, subject, percentage)
    @statewide_tests[name].race_ethnicity_data[race_ethnicity] = {year => {subject => percentage}}
  end

  def add_by_year(name, race_ethnicity, year, subject, percentage)
    @statewide_tests[name].race_ethnicity_data[race_ethnicity][year] = {subject => percentage}
  end

  def add_by_subject(name, race_ethnicity, year, subject, percentage)
    @statewide_tests[name].race_ethnicity[race_ethnicity][year][subject] = percentage
  end

  def grade(contents, grade)
    contents.each do |row|
      statewide_test_existence(row, grade)
    end
  end

  def statewide_test_existence(row, grade)
    name, year, subject, percentage = row[:location].upcase, row[:timeframe].to_i, row[:score].downcase, row[:data].to_f
    new_data(name, year, subject, percentage, grade)           if find_by_name(name)
    new_statewide_test(name, year, subject, percentage) unless find_by_name(name)
  end

  def new_data(name, year, subject, percentage, grade)
    if @statewide_tests[name].send(grade).keys.include?(year)
      @statewide_tests[name].send(grade)[year][subject.to_sym] = percentage
    else
      @statewide_tests[name].send(grade)[year] = {subject.to_sym => percentage}
    end
  end

  def new_statewide_test(name, year, subject, percentage)
    @statewide_tests[name] = create_statewide_test(name, year, subject, percentage)
  end

  def create_statewide_test(name, year, subject, percentage)
    statewide_test = StatewideTest.new(name)
    statewide_test.third_grade[year] = {subject.to_sym => percentage}
    return statewide_test
  end

  def find_by_name(name)
    @statewide_tests[name.upcase]
  end

end
