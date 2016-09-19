require_relative 'district'
require 'csv'
require 'pry'
require_relative 'enrollment_repository'
require_relative 'statewide_test_repository'
require_relative 'data_extractor'


class DistrictRepository
  include DataExtractor
  attr_reader :districts, :enrollments
  def initialize
    @districts = {}
  end

  def load_data(file_data)
    create_and_load_enrollments(file_data)
    create_and_load_statewide_tests(file_data)
    contents = DataExtractor.extract(file_data, :enrollment)
    contents = contents[:kindergarten]
    contents.each do |row|
      district_existence(row[:location])
    end
  end

  def create_and_load_enrollments(file_data)
    @enrollments = EnrollmentRepository.new
    @enrollments.load_data(file_data)
  end

  def create_and_load_statewide_tests(file_data)
    @statewide_tests = StatewideTestRepository.new
    @statewide_tests.load_data(file_data)
  end

  def district_existence(name)
    @districts[name.upcase] = District.new({name: name, enrollment: @enrollments.find_by_name(name), statewide_test: @statewide_tests.find_by_name(name)}) unless find_by_name(name)
  end

  def find_by_name(name)
    @districts[name.upcase]
  end

  def find_all_matching(name_fragment)
    @districts.keys.select do |district_name|
      district_name.upcase.include?(name_fragment.upcase)
    end
  end

end
dr = DistrictRepository.new
dr.load_data({
  :enrollment => {
    :kindergarten => "./data/Kindergartners in full-day program.csv",
    :high_school_graduation => "./data/High school graduation rates.csv",
  },
  :statewide_testing => {
    :third_grade => "./data/3rd grade students scoring proficient or above on the CSAP_TCAP.csv",
    :eighth_grade => "./data/8th grade students scoring proficient or above on the CSAP_TCAP.csv",
    :math => "./data/Average proficiency on the CSAP_TCAP by race_ethnicity_ Math.csv",
    :reading => "./data/Average proficiency on the CSAP_TCAP by race_ethnicity_ Reading.csv",
    :writing => "./data/Average proficiency on the CSAP_TCAP by race_ethnicity_ Writing.csv"
  }
})
require "pry"; binding.pry
district = dr.find_by_name("ACADEMY 20")
statewide_test = district.statewide_test
