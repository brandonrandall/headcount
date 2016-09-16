require 'csv'

module DataExtractor
  # def self.extract(file_data)
  #   file = extract_path(file_data)
  #   contents = CSV.read file, headers: true, header_converters: :symbol
  # end

  def self.extract(file_data)
    # require "pry"; binding.pry
    data = file_data[:enrollment]
    contents = {}
    data.each do |key,value|
      contents[key] = CSV.read value, headers: true, header_converters: :symbol
    end
    contents
  end

  def self.extract_path(file_data)
    file_data[:enrollment][:kindergarten]
  end
end
