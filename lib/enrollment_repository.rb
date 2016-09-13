require 'csv'
require_relative './enrollment'

class EnrollmentRepository

  def initialize
    @enrollments = {}
  end


  def load_data(hash)
    file = hash[:enrollment][:kindergarten]
    contents = CSV.read file, headers: true, header_converters: :symbol
    contents.each do |row|
      enrollment_existence(row)
    end
  end

  def enrollment_existence(row)
    name = row[:location]
    year = row[:timeframe]
    percentage = row[:data]

    if !find_by_name(name)
      @enrollments[name] = Enrollment.new({:name => name.upcase, :kindergarten_participation => {year => percentage}})
      require "pry"; binding.pry
    else
      @enrollments[name].kindergarten_participation_by_year[year] = data
    end
  end

  def find_by_name(name)
    @enrollments[name.upcase]
  end

end
