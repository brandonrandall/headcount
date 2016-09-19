require_relative 'district'
require 'csv'
require 'pry'
require_relative 'enrollment_repository'
require_relative 'statewide_test_repository'
require_relative 'data_extractor'


class DistrictRepository
  include DataExtractor
  attr_reader :districts, :enrollments, :statewide_tests
  def initialize
    @districts = {}
    @enrollments = {}
    @statewide_tests = {}
  end

  def load_data(file_data)
    create_and_load_enrollments(file_data) if file_data.keys.include?(:enrollment)
    create_and_load_statewide_tests(file_data) if file_data.keys.include?(:statewide_testing)
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
    if @statewide_tests.empty?
      data = {name: name, enrollment: @enrollments.find_by_name(name)}
    else
      data = {name: name, enrollment: @enrollments.find_by_name(name), statewide_test: @statewide_tests.find_by_name(name)}
    end
    @districts[name.upcase] = District.new(data) unless find_by_name(name)
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
