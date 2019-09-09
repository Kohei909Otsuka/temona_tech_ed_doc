class Result
  attr_reader :errs, :data

  def initialize(errs=[], data = nil)
    @errs = errs
    @data = data
  end

  def success?
    return @errs.empty?
  end
end
