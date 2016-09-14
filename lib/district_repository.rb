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

  def load_data(hash)
    contents = DataExtractor.extract(hash)
    @enrollments = EnrollmentRepository.new
    @enrollments.load_data(hash)
    contents.each do |row|
      district_existence(row[:location])
    end
  end

  def district_existence(name)
    if !find_by_name(name)
      @districts[name] = District.new({name: name.upcase, enrollment: @enrollments.find_by_name(name)})
    end
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
