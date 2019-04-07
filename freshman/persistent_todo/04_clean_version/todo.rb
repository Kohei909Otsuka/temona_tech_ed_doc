class Todo
  attr_accessor :id, :name
  def initialize(id, name)
    @id = id
    @name = name
  end

  def format
    return "{id: #{id}, name: #{name}}"
  end
end
