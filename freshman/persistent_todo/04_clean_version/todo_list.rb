require_relative "todo"

class TodoList
  def initialize(storage)
    @storage = storage
    @list = @storage.read.map do |hash|
      Todo.new(hash[:id], hash[:name])
    end

    set_next_id
    @search_index = {}
    @list.each {|todo| index(todo)}
  end

  def all
    return @list
  end

  def append(name)
    todo = Todo.new(@next_id, name)
    @list << todo
    set_next_id
    index(todo)
  end

  def update(id, name)
    target_index = find_index_by_id(id)
    return false if target_index.nil?

    todo = @list[target_index]
    unindex(todo)
    todo.name = name
    index(todo)
    return true
  end

  def remove(id)
    target_index = find_index_by_id(id)
    return false if target_index.nil?

    todo = @list[target_index]
    @list.delete_at(target_index)
    unindex(todo)
    return true
  end

  def close
    @storage.write(
      @list.map {|todo| {id: todo.id, name: todo.name}}
    )
  end

  def search(keyword)
    keyword = keyword.chomp
    p @search_index
    ids = @search_index[keyword] || []
    return ids
  end

  private

  def set_next_id
    if @list.length == 0
      @next_id = 1
    else
      @next_id = @list.map(&:id).sort.last + 1
    end
  end

  def index(todo)
    keywords = todo.name.split
    keywords.each do |key|
      if @search_index[key]
        @search_index[key].push(todo.id)
      else
        @search_index[key] = [todo.id]
      end
    end
  end

  def unindex(todo)
    keywords = todo.name.split
    keywords.each do |key|
      if @search_index[key]
        @search_index[key].delete(todo.id)
        @search_index.delete(key) if @search_index[key].length == 0
      end
    end
  end

  def find_index_by_id(id)
    return @list.index {|todo| todo.id == id}
  end
end
