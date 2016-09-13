require_relative '../lib/enrollment'
require 'csv'
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
    year = row[:timeframe].to_i
    percentage = clean(row[:data])
    if !find_by_name(name)
      @enrollments[name] = Enrollment.new({:name => name, :kindergarten_participation => {year => percentage}})
    else
      @enrollments[name].kindergarten_participation_by_year[year] = data
    end
  end


    def clean(value)
      value.to_s[0..4].to_f
    end

  def find_by_name(name)
    @enrollments[name.upcase]
  end


end
