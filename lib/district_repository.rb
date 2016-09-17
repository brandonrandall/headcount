require_relative 'district'
require 'csv'
require 'pry'
require_relative 'enrollment_repository'
require_relative 'data_extractor'


class DistrictRepository
  include DataExtractor
  attr_reader :districts, :enrollments
  def initialize
    @districts = {}
  end

  def load_data(file_data)
    @enrollments = EnrollmentRepository.new
    @enrollments.load_enrollment_data(file_data)
    contents = DataExtractor.extract(file_data)
    contents = contents[:kindergarten]
    contents.each do |row|
      district_existence(row[:location])
    end
  end

  def district_existence(name)
    @districts[name.upcase] = District.new({name: name, enrollment: @enrollments.find_by_name(name)}) unless find_by_name(name)
  end

  def find_by_name(name)
    # require "pry"; binding.pry
    @districts[name.upcase]
  end

  def find_all_matching(name_fragment)
    @districts.keys.select do |district_name|
      district_name.upcase.include?(name_fragment.upcase)
    end
  end

end
