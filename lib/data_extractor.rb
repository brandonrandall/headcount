require 'csv'

module DataExtractor

  def self.extract(file_data, type)
    # type = check_path(file_data)
    data = file_data[type]
    contents = {}
    data.each do |key,value|
      contents[key] = CSV.read value, headers: true, header_converters: :symbol
    end
    contents
    # require "pry"; binding.pry
  end

end
