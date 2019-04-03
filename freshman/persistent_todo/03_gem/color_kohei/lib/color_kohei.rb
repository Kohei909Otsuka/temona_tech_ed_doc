module Color
  def self.red str
    return "\e[31m#{str}\e[0m"
  end

  def self.green str
    return "\e[32m#{str}\e[0m"
  end
end
