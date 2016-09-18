module Clean

  def self.three_truncate(percentage)
    percentage.to_s[0..4].to_f
  end

  def self.three_round(percentage)
    percentage.round(3)
  end

  def self.race_ethnicity(race_ethnicity)
    race_ethnicity = race_ethnicity.downcase
    if race_ethnicity == "hawaiian/pacific islander"
      race_ethnicity.gsub!("hawaiian/", "")
      race_ethnicity.gsub!(" ", "_").to_sym
    else
      race_ethnicity.gsub!(" ", "_").to_sym
    end
  end

end
