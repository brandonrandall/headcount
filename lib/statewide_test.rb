class StatewideTest
  attr_reader :third_grade, :eighth_grade, :race_ethnicity_data
  def initialize(name)
    @name         = name
    @third_grade  = {}
    @eighth_grade = {}
    @race_ethnicity_data = {}
  end

  def proficient_by_grade(grade)
    # require "pry"; binding.pry
    if grade == 3
      third_grade_polish
    elsif grade == 8
      eighth_grade_polish
    end
  end

  def third_grade_polish
    third_grade = @third_grade.each do |year, data|
      data.each do |subject, percentage|
        data[subject] = Clean.three_truncate(percentage)
      end
    end
    third_grade
  end

  def eighth_grade_polish
    eighth_grade = @eighth_grade.each do |year, data|
      data.each do |subject, percentage|
        data[subject] = Clean.three_truncate(percentage)
      end
    end
    eighth_grade
  end

  def proficient_by_race_or_ethnicity(race)
    race_data = @race_ethnicity_data[race].each do |year, data|
      data.each do |subject, percentage|
        data[subject] = Clean.three_truncate(percentage)
      end
    end
    race_data
  end

  def proficient_for_subject_by_grade_in_year(subject, grade, year)
    if grade == 3
      Clean.three_truncate(@third_grade[year][subject])
    elsif grade == 8
      Clean.three_truncate(@eighth_grade[year][subject])
    end
  end

  def proficient_for_subject_by_race_in_year(subject, race, year)
    Clean.three_truncate(@race_ethnicity_data[race][year][subject])
  end

end
