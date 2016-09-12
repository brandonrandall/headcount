require_relative 'district'
require 'csv'
require 'pry'
class DistrictRepository
  attr_accessor :districts
  def initialize
    @districts = {}
  end

  def load_data(hash)
    file = hash[:enrollment][:kindergarten]
    contents = CSV.read file, headers: true, header_converters: :symbol
    contents.each do |row|
      district_existence(row[:location])
    end
  end

  def district_existence(name)
    if !find_by_name(name)
      @districts[name] = District.new({name: name.upcase})
    end
  end

  def find_by_name(name)
    @districts[name.upcase]
  end

end
