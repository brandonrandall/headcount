require_relative 'district'
require 'csv'
require 'pry'
require_relative 'enrollment_repository'
class DistrictRepository
  attr_reader :districts, :enrollment
  def initialize
    @districts = {}
  end

  def load_data(hash)
    file = hash[:enrollment][:kindergarten]
    contents = CSV.read file, headers: true, header_converters: :symbol
    @enrollments = EnrollmentRepository.new
    @enrollments.load_data(hash)
    contents.each do |row|
      district_existence(row[:location])
    end
    require "pry"; binding.pry
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
