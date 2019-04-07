require_relative "todo"

class TodoList
  def initialize(storage)
    @storage = storage
    @list = @storage.read.map do |hash|
      Todo.new(hash[:id], hash[:name])
    end
  end

  def all
    return @list
  end

  def append(name)
    @list << Todo.new(@list.length + 1, name)
  end

  def update(id, name)
    # index見つける
    target_index = find_index_by_id(id)
    return false if target_index.nil?
    todo = @list[target_index]
    todo.name = name
    return true
  end

  def remove(id)
    target_index = find_index_by_id(id)
    return false if target_index.nil?
    @list.delete_at(target_index)
    return true
  end

  def close
    @storage.write(
      @list.map {|todo| {id: todo.id, name: todo.name}}
    )
  end

  private

  def find_index_by_id(id)
    return @list.index {|todo| todo.id == id}
  end
end
