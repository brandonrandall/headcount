require_relative '../lib/enrollment'
require 'csv'
require_relative './enrollment'
require_relative 'data_extractor'

class EnrollmentRepository
  include DataExtractor
  attr_reader :enrollment
  def initialize
    @enrollments = {}
  end

  def load_data(hash)
    contents = DataExtractor.extract(hash)
    contents.each do |row|
      enrollment_existence(row)
    end
  end

  def enrollment_existence(row)
    name, year, percentage = row[:location].upcase, row[:timeframe].to_i, row[:data].to_f
    add_new_data(name, year, percentage)            if find_by_name(name)
    add_new_enrollment_data(name, year, percentage) unless find_by_name(name)
  end

  def add_new_enrollment_data(name, year, percentage)
    @enrollments[name] = create_enrollment(name, year, percentage)
  end

  def add_new_data(name, year, percentage)
    @enrollments[name].kindergarten_participation[year] = percentage
  end

  def create_enrollment(name, year, percentage)
    Enrollment.new({:name => name, :kindergarten_participation => {year => percentage}})
  end

  def find_by_name(name)
    @enrollments[name.upcase]
  end


end
