module Clean

  def self.three_truncate(percentage)
    percentage.to_s[0..4].to_f
  end

  def self.three_round(percentage)
    percentage.round(3)
  end

  

end
