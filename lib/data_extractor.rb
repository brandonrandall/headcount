require 'csv'

module DataExtractor

  def self.extract(file_data)
    data = file_data[:enrollment]
    contents = {}
    data.each do |key,value|
      contents[key] = CSV.read value, headers: true, header_converters: :symbol
    end
    contents
  end

end
