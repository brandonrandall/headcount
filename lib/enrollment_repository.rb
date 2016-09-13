require 'csv'
class EnrollmentRepository

  def initialize
    @enrollments = [
      {
        name: "enr1"
      },
      {
        name: "enr2"
      }
    ]
  end


  def load_data(hash)
    file = hash[:enrollment][:kindergarten]
    contents = CSV.read file, headers: true, header_converters: :symbol
    binding.pry
    # contents.each do |row|

  end

end
