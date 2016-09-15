require 'csv'

module DataExtractor
  def self.extract(hash)
    file = extract_path(hash)
    contents = CSV.read file, headers: true, header_converters: :symbol
  end

  def self.extract_path(hash)
    hash[:enrollment][:kindergarten]
  end
end
