class StatewideTest
  attr_reader :third_grade, :eighth_grade, :math, :reading, :writing
  def initialize(name)
    @name         = name
    @third_grade  = {}
    @eighth_grade = {}
    @math         = {}
    @reading      = {}
    @writing      = {}
  end

  # def proficient_by_grade(grade)
  # end
  #
  # def proficient_by_race_or_ethnicity(race)
  # end
  #
  # def proficient_for_subject_by_grade_in_year(subject, grade, year)
  # end
  #
  # def proficient_for_subject_by_race_in_year
  # end

end
