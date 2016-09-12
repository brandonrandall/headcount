class Enrollment
  attr_reader :name, :kindergarten_participation
  def initialize(hash)
    @name = hash[:name]
    @kindergarten_participation = hash[:kindergarten_participation]
  end
end
