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
    name = row[:location]
    year = row[:timeframe].to_i
    percentage = clean(row[:data])

    if !find_by_name(name)
      @enrollments[name] = Enrollment.new({:name => name.upcase, :kindergarten_participation => {year => percentage}})
    else
      @enrollments[name].kindergarten_participation_by_year[year] = percentage
    end
  end

  def clean(percentage)
    percentage.to_s[0..4].to_f
  end


  def find_by_name(name)
    @enrollments[name.upcase]
  end


end
