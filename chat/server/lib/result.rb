class Result
  attr_reader :errs

  def initialize(errs=[])
    @errs = errs
  end

  def success?
    return @errs.empty?
  end
end
